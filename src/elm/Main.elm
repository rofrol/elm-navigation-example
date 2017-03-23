module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (Location)
import Html.Events.Extra exposing (onClickPreventDefault)
import UrlParser as Url
import Time exposing (Time)


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



-- MODEL


type alias Model =
    { history : List Location
    , route : Route
    , flags : Flags
    }


type alias Flags =
    { data_server : String
    , currentTime : Time
    }


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    ( Model [ location ] (parseLocation location) flags
    , Cmd.none
    )



-- UPDATE


type Msg
    = UrlChange Location
    | NavigateTo Route


type Route
    = HomeRoute
    | SettingsRoute
    | NotFoundRoute


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | history = location :: model.history, route = parseLocation location }
            , Cmd.none
            )

        NavigateTo route ->
            ( model
            , Navigation.newUrl (reverseRoute route)
            )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Pages" ]
        , div [] [ text <| "unix epoch time " ++ (toString model.flags.currentTime) ]
        , ul [] (List.map viewLink [ HomeRoute, SettingsRoute ])
        , ul [] [ li [] [ a [ href "/non_existing_link" ] [ text "non existing link" ] ] ]
        , pageView model
        , h1 [] [ text "History" ]
        , ul [] (List.map viewLocation model.history)
        ]


pageView : Model -> Html Msg
pageView model =
    div []
        [ text
            (case model.route of
                HomeRoute ->
                    "Home"

                SettingsRoute ->
                    "Settings"

                NotFoundRoute ->
                    "404 :("
            )
        ]


viewLink : Route -> Html Msg
viewLink route =
    li [] [ a [ href (reverseRoute route), onClickPreventDefault (NavigateTo route) ] [ text (reverseRoute route) ] ]


viewLocation : Location -> Html Msg
viewLocation location =
    li [] [ text (location.pathname) ]


reverseRoute : Route -> String
reverseRoute route =
    case route of
        HomeRoute ->
            "/"

        SettingsRoute ->
            "/settings"

        NotFoundRoute ->
            ""


routeParser : Url.Parser (Route -> a) a
routeParser =
    Url.oneOf
        [ Url.map HomeRoute Url.top
        , Url.map SettingsRoute (Url.s "settings")
        ]


parseLocation : Location -> Route
parseLocation location =
    location
        |> Url.parsePath routeParser
        |> Maybe.withDefault NotFoundRoute
