import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Char


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
  , validationMessage: (String, String)
  }


model : Model
model =
  Model "" "" "" "" ("", "")



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Validate


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      { model | age = age }

    Validate ->
      let
        (color, message) =
          if model.password /= model.passwordAgain then
            ("red", "Passwords do not match!")
          else if String.length model.password < 8 then
            ("red", "Password must have at least 8 characters")
          else if String.any Char.isDigit model.password == False
            || String.any Char.isLower model.password == False
            || String.any Char.isUpper model.password == False then
            ("red", "Password must have digits, uppercase and lowercase letters")
          else if String.all Char.isDigit model.age == False then
            ("red", "Age must be a number")
          else
            ("green", "OK")
      in
        { model | validationMessage = (color, message) }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , button [onClick Validate ] [ text "Submit" ]
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) = .validationMessage model
  in
    div [ style [("color", color)] ] [ text message ]
