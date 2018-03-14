import Html exposing (Html, button, div, text, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

type alias Tags = List String
model : Tags
model = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina"]

renderList lst =
    ul []
        (map (\l -> li [] [ text l ]) lst)

type Msg
  = Complete String

update : Msg -> Tags -> Tags
update msg model =
  case msg of
    Complete value ->
      ["sup bro"]

view : Tags -> Html Msg
view model =
  div []
    [
      input [id "myInput", type_ "text", name "myCountry", placeholder "country", onInput Complete] []
      div [class "autocomplete-items"]
      renderList model
    ]
