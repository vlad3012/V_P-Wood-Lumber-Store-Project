let selectedOrders = false;

$(document).ready(function () {

    $("#formOrder").click(function (event) {
        submitOrder("/cart/submit");
    });

    $("#payForOrder").click(function (event) {
        if (checkPaymentInfo()) {
            submitOrder("/cart/submitAndPay");
        } else {
            showNotification(messages['message.cart.paymentInfo.failure'], "danger")
        }
    });

    $("#order_selectAll").click(function () {
        selectAll('order', !selectedOrders);
        selectedOrders = !selectedOrders;
    });

    $('input[type=radio][name="delivery"]').change(function () {
        if (this.value === "delivery") {
            $('#deliveryInfo').show();
        } else {
            $('#deliveryInfo').hide();
        }
    });

    $('input[type=radio][name="payment"]').change(function () {
        if (this.value === "card") {
            $('#payForOrder').show();
            $('#cardInfo').show();
        } else {
            $('#payForOrder').hide();
            $('#cardInfo').hide();
        }
    });

});

function selectAll(id, value) {

    $('#total').text(0);
    $('#' + id + '>tr').each(function () {
        let currentSelectPoint = $(this).find('.form-check-label>input[id*="selected_"]');
        $(currentSelectPoint).prop('checked', value);
        if (value === false) {
            $('#total').text(0);
        } else {
            calculateCost(currentSelectPoint);
        }
    });
}

function calculateCost(element) {

    let currentRow = $(element).parents('tr');
    let cost = Number.parseFloat(currentRow.find('td[id*="cost_"]').text()) || 0;
    let total = Number.parseFloat($('#total').text()) || 0;
    if ($(element).is(':checked')) {
        total += cost;
    } else {
        total -= cost;
    }
    $('#total').text(total);

}

function deleteCartOrder(url, element) {

    $.ajax({
        type: "POST",
        url: url,
        success: function (response) {

            if (response.status === "OK") {
                $(element).parents("tr").remove();
                $('#total').text(0);
                $('#order>tr').each(function () {
                    let currentSelectPoint = $(this).find('.form-check-label>input[id*="selected_"]');
                    if ($(currentSelectPoint).is('checked')) {
                        $('#total').text(0);
                    } else {
                        calculateCost(currentSelectPoint);
                    }
                });
                showNotification(response.message, "success");
            }
        },
        error: function (e) {

            showNotification(messages['message.notification.loadingData.failure'], "danger");
        }
    });
}

function submitOrder(url) {

    let ordersArray = getOrdersArray();

    if (ordersArray.length === 0) {
        showNotification(messages['message.notification.cart.orderSelect'], "warning");
        return;
    }

    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(ordersArray),
        contentType: "application/json",
        success: function (response) {
            // we have the response
            if (response.status === "OK") {
                $('#order>tr').each(function () {
                    if (!$(this).find('.form-check-label>input[id*="selected_"]').is(":checked")) {
                        return true;
                    }
                    $(this).remove();
                });
                $('#total').text('');
                showNotification(response.message, "success");
            }
        },
        error: function (e) {
            showNotification(messages['message.notification.loadingData.failure'], "danger");
        }
    });
}

function getOrdersArray() {

    let array = [];

    $('#order>tr').each(function () {
        if (!$(this).find('.form-check-label>input[id*="selected_"]').is(":checked")) {
            return true;
        }

        let object = {};

        object['id'] = Number.parseInt(($(this).find('input[id*="id_"]').val()) || 0);
        object['delivery'] = $('input[name="delivery"]:checked').val() === "delivery";
        object['deliveryAddress'] = $('#address').val();
        object['paymentMethod'] = $('input[name="payment"]:checked').val().toUpperCase();

        array.push(object);
    });

    return array;
}

function checkPaymentInfo() {

    let check = true;
    let fieldsToCheck = [];

    fieldsToCheck.push($('#cardNumber'));
    fieldsToCheck.push($('#cardName'));
    fieldsToCheck.push($('#expired'));
    fieldsToCheck.push($('#cvv'));

    fieldsToCheck.forEach(function (item) {
        if (item.val() === "") {
            check = false;
            item.parent().addClass('has-danger');
            item.addClass('form-control-danger')
        }
    });

    return check
}