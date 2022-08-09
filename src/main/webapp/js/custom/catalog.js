$(document).ready(function () {

    $("#file_upload").on("change", function (event) {
        $('#file_upload_name').text($('#file_upload')[0].files[0].name);
    });

    $("#save").click(function () {
        if ($('#file_upload')[0].files.length === 0) {
            showNotification(messages['message.notification.catalog.upload.validate'], "warning");
        } else {
            saveCatalogItem();
            $('#file_upload_name').text('');
        }
    });

})

function saveCatalogItem() {

    let dataForm = new FormData();
    dataForm.append("file", $('#file_upload')[0].files[0]);
    dataForm.append("productType", $('#productType').val());

    $.ajax({
        type: "POST",
        url: "/catalog/settings/upload",
        cache: false,
        contentType: false,
        processData: false,
        data: dataForm,
        success: function (response) {

            if (response.status === 'OK') {

                if (response.redirect) {
                    window.location.replace(response.redirectUrl)
                }
            }

        },
        error: function (e) {

            showNotification(messages['message.notification.catalog.upload.failure'], "danger");
        }
    });
}

function deleteCatalogItem(url, element) {

    $.ajax({
        type: "POST",
        url: url,
        success: function (response) {

            if(response.status === "OK") {
                $(element).parents("[id*='catalogItem']").remove();
                showNotification(response.message, "success");
            }
        },
        error: function (e) {

            showNotification(messages['message.notification.loadingData.failure'], "danger");
        }
    });
}


