/*
var variable = document.getElementbyId("button")
variable.onclick(function() {
    Date();
}
*/

var button = document.getElementbyId("#button");

button.onClick(function() {
    document.getElementbyId('demo').innerHTML = Date();
}

<button id="button">Click!></button>