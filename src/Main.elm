module Main exposing (..)

import Browser
import Html exposing (Html, div, form, h1, img, input, p, text)
import Html.Attributes as Attr exposing (default, src, value)
import Html.Events exposing (onInput, onSubmit)



---- MODEL ----


type alias Person =
    String


type alias Model =
    { people : List Person
    , nameInput : String
    }


init : ( Model, Cmd Msg )
init =
    ( { people = []
      , nameInput = ""
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = FieldChanged String
    | NameAdded


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FieldChanged newValue ->
            ( { model
                | nameInput = newValue
              }
            , Cmd.none
            )

        NameAdded ->
            ( { nameInput = ""
              , people = model.nameInput :: model.people
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [] (viewTitle :: viewForm model :: viewPeople model)


viewTitle : Html Msg
viewTitle =
    h1 [] [ text "Adicione uma pessoa: " ]


viewForm : Model -> Html Msg
viewForm model =
    form
        [ onSubmit NameAdded ]
        [ input
            [ value model.nameInput
            , onInput FieldChanged
            ]
            []
        ]


viewPeople : Model -> List (Html Msg)
viewPeople model =
    List.map viewPerson model.people


viewPerson : Person -> Html Msg
viewPerson person =
    h1 [] [ text person ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
