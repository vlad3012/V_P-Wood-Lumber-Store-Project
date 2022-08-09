let selectedGlass = false;
let selectedProcessing = false;
let selectedAccessory = false

$(document).ready(function () {
    $("#priceListForm").submit(function (event) {
        event.preventDefault();
        doAjaxPost();
    });
    $("#glass_selectAll").click(function () {
        selectAll('glass', !selectedGlass);
        selectedGlass = !selectedGlass;
    });
    $("#processing_selectAll").click(function () {
        selectAll('processing', !selectedProcessing);
        selectedProcessing = !selectedProcessing
    });
    $("#accessory_selectAll").click(function () {
        selectAll('accessory', !selectedAccessory);
        selectedAccessory = !selectedAccessory;
    });
    $("#updatePrices").click(function () {
        updatePrices('glass');
        updatePrices('processing');
        updatePrices('accessory');
        showNotification(messages['message.notification.priceList.update.success'], 'success');
    });
});

function convertTableToJSON(id) {

    let myRows = [];
    //loop through tr
    $('#' + id + '>tr').each(function () {
        if (!$(this).find('.form-check-label>input[id*="selected_"]').is(":checked")) {
            return true;
        }

        let obj = {} //create obj

        //add value to it
        obj["id"] = $(this).find('td[id*="id_"]').text();
        obj["name"] = $(this).find('td[id*="name_"]').text();
        obj["priceUSD"] = Number.parseFloat($(this).find('td>input[id*="priceUSD_"]').val()) || 0;
        obj["price"] = Number.parseFloat($(this).find('td>input[id*="price_"]').val()) || 0;
        if ($(this).find('td[id*="thickness_"]').length) {
            obj["thickness"] = Number.parseInt($(this).find('td[id*="thickness_"]').text()) || 0;
        }

        myRows.push(obj) //push obj to array
    });

    return JSON.stringify(myRows);

}

function selectAll(id, value) {

    $('#' + id + '>tr').each(function () {
        $(this).find('.form-check-label>input[id*="selected_"]').prop('checked', value);
    });
}

function updatePrices(id) {
    $('#' + id + '>tr').each(function () {
        if (!$(this).find('.form-check-label>input[id*="selected_"]').is(":checked")) {
            return true;
        }

        let priceUSD = Number.parseFloat($(this).find('td>input[id*="priceUSD_"]').val()) || 0;
        let currency = Number.parseFloat($('#currency').val()) || 0;
        let increasePercent = Number.parseFloat($('#increasePercent').val()) || 0;
        let price = Math.floor(priceUSD * currency * (1 + increasePercent / 100) * 100) / 100;
        $(this).find('td>input[id*="price_"]').val(price);
    });
}

function doAjaxPost() {
    // get the form values
    let tableJsonGlass = convertTableToJSON('glass');
    let tableJsonProcessing = convertTableToJSON('processing');
    let tableJsonAccessory = convertTableToJSON('accessory');

    let dataForm = {};
    dataForm["glassList"]= tableJsonGlass;
    dataForm["processingList"]= tableJsonProcessing;
    dataForm["accessoryList"] = tableJsonAccessory;

    $.ajax({
        type: "POST",
        url: "/priceList/",
        data: dataForm,

        success: function (response) {
            // we have the response
            if (response.status === "OK") {
               showNotification(response.message, 'success')
            }
        },
        error: function (e) {

            showNotification(messages['message.notification.loadingData.failure'], "danger");
        }
    });
}

function setSelect(id){

    let currentRow = $('#'+id).parents('tr');
    $(currentRow).find('.form-check-label>input[id*="selected_"]').prop('checked', true);
}

