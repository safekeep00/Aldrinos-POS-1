function preventbackbutton() {
    window.history.forward();
}
setTimeout("preventbackbutton()", 0);
window.onunload = function () { null };