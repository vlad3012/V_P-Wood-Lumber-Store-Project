function sendMessage() {
    let Json = JSON.stringify(getMessage());

    $.ajax({
        type: "POST",
        url: "/send",
        contentType: "application/json",
        data: Json,
        success: function (response) {

            if (response.status === "OK") {
                showNotification(messages.successfulRequest, "success");
            } else {

                if (response.result.length === 0) {
                    showNotification(messages.failRequest, "danger");
                } else {
                    response.result.forEach(function (item) {
                        $('#error_' + item.field.replace('customer.', '')).text(messages[item.code]);
                        $('#' + item.field.replace('customer.', '')).addClass('form-control-danger');
                        $('#group_' + item.field.replace('customer.', '')).addClass('has-danger');
                    });
                }
            }

        },
        error: function (e) {
            showNotification(messages.failRequest, "danger");
        }
    });
}

function getMessage() {

    let object = {};

    let customer = {};
    customer['name'] = $('#name').val();
    customer['email'] = $('#email').val();
    customer['phone'] = $('#phone').val();

    object['customer'] = customer;
    object['topic'] = $('#topic').val();
    object['message'] = $('#message').val();

    return object;
}