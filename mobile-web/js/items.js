var cart = [];
var product_items = {};

fetch("../fetchProducts.php", {
// fetch("/pos/mobile-web/fetchProducts.php", {
    method: "GET",
}).then(function (response) {
    return response.text();
}).then(function (response) {
    product_items = JSON.parse(response);
});
