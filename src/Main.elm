module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { housingPercentage : Float
    , investingPercentage : Float
    , leisurePercentage : Float
    , housingUpperBound : Float
    , housingLowerBound : Float
    }


init : Model
init =
    Model 0 0 0 0 0



-- UPDATE


type Msg
    = HousingP String
    | InvestingP String
    | LeisureP String
    | HousingUB String
    | HousingLB String


update : Msg -> Model -> Model
update msg model =
    case msg of
        HousingP housingPercentage ->
            { model | housingPercentage = housingPercentage |> String.toFloat |> Maybe.withDefault 0 }

        InvestingP investingPercentage ->
            { model | investingPercentage = investingPercentage |> String.toFloat |> Maybe.withDefault 0 }

        LeisureP leisurePercentage ->
            { model | leisurePercentage = leisurePercentage |> String.toFloat |> Maybe.withDefault 0 }

        HousingUB housingUpperBound ->
            { model | housingUpperBound = housingUpperBound |> String.toFloat |> Maybe.withDefault 0 }

        HousingLB housingLowerBound ->
            { model | housingLowerBound = housingLowerBound |> String.toFloat |> Maybe.withDefault 0 }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "number" "Housing %" (String.fromFloat model.housingPercentage) HousingP
        , viewInput "number" "Investing %" (String.fromFloat model.investingPercentage) InvestingP
        , viewInput "number" "Leisure %" (String.fromFloat model.leisurePercentage) LeisureP
        , viewInput "number" "Housing Min" (String.fromFloat model.housingLowerBound) HousingLB
        , viewInput "number" "Housing Max" (String.fromFloat model.housingUpperBound) HousingUB
        , validationMessage model
        ]


viewInput : String -> String -> String -> (String -> Msg) -> Html Msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


validationMessage : Model -> Html Msg
validationMessage model =
    if model.housingPercentage + model.investingPercentage + model.leisurePercentage == 100 then
        span [ style "color" "green" ] [ text "Nice" ]

    else
        span [ style "color" "red" ] [ text "Percentages must add to 100" ]
