import css from "../css/app.scss"
import "phoenix_html"
import {
    Socket
} from "phoenix"
import LiveSocket from "phoenix_live_view"
import LiveReact, {
    initLiveReact
} from "phoenix_live_react"


import Chart from "./components/chart.jsx"

window.Components = {
    Chart
}


let csrfToken = document
    .querySelector("meta[name='csrf-token']")
    .getAttribute("content")

document.addEventListener("DOMContentLoaded", e => {
    initLiveReact()
})

let hooks = {
    LiveReact
}

let liveSocket = new LiveSocket("/live", Socket, {
    hooks,
    params: {
        _csrf_token: csrfToken
    }
})
liveSocket.connect()
console.log("Connect to LiveSocket")