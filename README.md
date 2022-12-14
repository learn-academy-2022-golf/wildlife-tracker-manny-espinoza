Documentation:

Verify correct location.

    $ rails new rails-api -d postgresql -T
    $ cd rails-api
    $ rails db:create

Add remote from github
Create main branch
Make an initial commit

    $ git status
    $ git add .
    $ git status
    $ git commit -m ""
    $ git push origin main





BRANCH: animal-crud-actions

    $ git checkout -b branch-name
    $ bundle add rspec-rails
    $ rails generate rspec:install
    $ code .

Create a resource for animal with the following information: common name and scientific binomial

    $ rails g resource Animal common_name:string scientific_binomial:string
    $ rm -r app/views/animals
    $ rails routes
    $ rails db:migrate

CRUD actions for animals in database.

app/controllers/animals_controller.rb

    def index
        animals = Animal.all
        render json: animals
    end

    def show
        animal = Animal.find(params[:id])
        render json: animal
    end

    def create
        animal = Animal.create(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end

    def update
        animal = Animal.find(params[:id])
        animal.update(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end

    def destroy
        animal = Animal.find(params[:id])
        if animal.destroy
            render json: animal
        else
            render json: animal.errors
        end
    end

    private
    def animal_params
        params.require(:animal).permit(:common_name, :scientific_binomial)
    end

app/controllers/application_controller.rb

    skip_before_action :verify_authenticity_token





BRANCH: sighting-crud-actions

Create a resource for animal sightings with the following information: latitude, longitude, date

    $ rails g resource Sighting latitude:integer longitude:integer date:string animal_id:integer
    $ rails db:migrate

CRUD actions for sightings in database

app/controllers/sightings_controller.rb

    def index
        sightings = Sighting.all
        render json: sightings
    end

    def show
        sighting = Sighting.find(params[:id])
        render json: sighting
    end

    def create
        sighting = Sighting.create(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    def update
        sighting = Sighting.find(params[:id])
        sighting.update(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    def destroy
        sighting = Sighting.find(params[:id])
        if sighting.destroy
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    private
    def sighting_params
        params.require(:sighting).permit(:latitude, :longitude, :date, :animal_id)
    end

app/models/animal.rb

    has_many :sightings

app/models/sighting.rb

    belongs_to :animal





BRANCH: animal-sightings-reports

Changed files

app/controllers/animals_controller.rb

    def show
        animal = Animal.find(params[:id])
        - render json: animal
        + render json: animal.to_json(include: [:sightings])
    end

app/controllers/sightings_controller.rb

    def index
        - sightings = Sighting.all
        - render json: sightings
        + sightings = Sighting.where(date: params[:start_date]..params[:end_date])
        + render json: sightings.to_json(include: [:animal])
    end

    def show
        sighting = Sighting.find(params[:id])
        - render json: sighting
        + render json: sighting.to_json(include: [:animal])
    end

    private
    def sighting_params
        - params.require(:sighting).permit(:latitude, :longitude, :date, :animal_id)
        + params.require(:sighting).permit(:latitude, :longitude, :date, :animal_id, :start_date, :end_date)
    end





BRANCH: animal-sighting-specs

Create validations to ensure a number of things
    - Validation error if animal doesn't include a common name and scientific binomial
    - Validation error if sighting doesn't include latitude, longitude, or date
    - Validation error if an animal's common name exactly matches the scientific binomial
    - Validation error if the animal's common name and scientific binomial are not unique
    - Can see status code 422 when a post request can not be completed because of validation errors