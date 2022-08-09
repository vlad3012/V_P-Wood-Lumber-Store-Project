let glassTypeList = [];
let processingList = [];
let accessoryList = [];

$(document).ready(function () {

    if ($('#installation').val() === "true") {
        $("#installation").prop("checked", true);
    }

    getGlassData();
    getProcessingData();
    getAccessory();


    $().ready(function () {

        $("#addRaw").click(function () {
            addGlassRow();
        });

        $("#addAccessoryRaw").click(function () {
            addAccessoryRow();
        });

        $("#calculate").click(function (event) {
            doAjaxCalculatePost();
        });

        $('#addOrder').click(function () {
            doAjaxSaveOrderPost();
        });

        $('#addTemplate').click(function () {
            doAjaxSaveTemplatePost();
        });
        $('#addToCart').click(function () {
            doAjaxAddToCartPost();
        });
    });

});

function getGlassData() {

    $.ajax({
        type: "GET",
        url: "/component/list?componentType=glassType",
        success: function (response) {
            glassTypeList = response;
            $("#glass>tr").each(function () {
                let glassTypeSelect = prepareGlassType($(this));
                prepareThickness(glassTypeSelect);
                $(this).find('#glassType').change(function () {
                    prepareThickness($(this));
                });

                $(this).find('#delete').click(function () {
                    if ($(this).parents("tr")[0].id != "row_1") {
                        $(this).parents("tr").remove();
                    } else {
                        showNotification(messages.firstRow, "warning")
                    }
                });

                $(this).find('#addProcessing').click(function () {
                    addProcessingRow($(this).parents("tr")[0]);
                });
            });
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });

}

function getProcessingData() {

    $.ajax({
        type: "GET",
        url: "/component/list?componentType=processing",
        success: function (response) {
            processingList = response;
            $("#glass>tr").each(function () {
                let glassRow = $(this);
                $(this).find('#processing>tr').each(function () {
                    let type = prepareProcessingType(glassRow, $(this));
                    prepareProcessingName(type);
                    manageProcessingInputsVisibility($(this));

                    $(this).find('#addProcessing').click(function () {
                        addProcessingRow($(this).parents("tr")[0]);
                    });

                    $(this).find('#type').change(function () {
                        prepareProcessingName($(this));
                        manageProcessingInputsVisibility($(this).parents('#processing>tr')[0]);
                    });

                    $(this).find('#delete').click(function () {
                        $(this).parents("#processing>tr").remove();
                    });

                });
            });
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });

}

function getAccessory() {

    $.ajax({
        type: "GET",
        url: "/component/list?componentType=accessory",
        success: function (response) {
            accessoryList = response;
            $("#accessories>tr").each(function () {
                prepareAccessory($(this));

                $(this).find('#delete').click(function () {
                    $(this).parents("#accessories>tr").remove();
                });
            });
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });

}

////Prepare data////
function prepareData() {
    $.ajax({
        type: "POST",
        url: "/component/getData",
        success: function (response) {
            // we have the response
            if (response.status === "OK") {
                let result = JSON.parse(response.result);
                glassTypeList = result.glassTypeList;
                processingList = result.processingList;
                $("#glass>tr").each(function () {
                    let glassTypeSelect = prepareGlassType($(this));
                    prepareThickness(glassTypeSelect);
                    let glassRow = $(this);
                    $(this).find('#glassType').change(function () {
                        prepareThickness($(this));
                    });

                    $(this).find('#delete').click(function () {
                        if ($(this).parents("tr")[0].id != "row_1") {
                            $(this).parents("tr").remove();
                        } else {
                            showNotification(messages.firstRow, "warning")
                        }
                    });

                    $(this).find('#addProcessing').click(function () {
                        addProcessingRow($(this).parents("tr")[0]);
                    });

                    $(this).find('#processing>tr').each(function () {
                        let type = prepareProcessingType(glassRow, $(this));
                        prepareProcessingName(type);
                        manageProcessingInputsVisibility($(this));

                        $(this).find('#addProcessing').click(function () {
                            addProcessingRow($(this).parents("tr")[0]);
                        });

                        $(this).find('#type').change(function () {
                            prepareProcessingName($(this));
                            manageProcessingInputsVisibility($(this).parents('#processing>tr')[0]);
                        });

                        $(this).find('#delete').click(function () {
                            $(this).parents("#processing>tr").remove();
                        });

                    });
                });
            }
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });
}

function prepareGlassType(currentRow) {

    let glassTypeSelect = $(currentRow).find('#glassType');
    let selectedOption = $(glassTypeSelect).find('option:selected');
    glassTypeSelect.empty();

    glassTypesSet = new Set();
    glassTypeList.forEach(function (item) {
        glassTypesSet.add(item.name)
    });

    let select = "";
    glassTypesSet.forEach(function (item) {
        let selected = "";
        if (selectedOption.val() !== "") {
            if (item === selectedOption.val()) {
                selected = "selected";
            }
        }
        let option = "<option " + selected + " value=" + item + ">" + item + "</option>";
        select += option;
    });

    glassTypeSelect.append(select);

    return glassTypeSelect;
}

function prepareThickness(selected) {

    let currentGlassType = selected.find('option:selected').val();
    let currentRow = selected.parents("tr");
    let thicknessSelect = $(currentRow).find('#thickness');
    let selectedOption = $(thicknessSelect).find('option:selected');
    thicknessSelect.empty();

    let thicknessList = glassTypeList
        .filter(type => type.name === currentGlassType)
        .sort(function (a, b) {
            return a.thickness - b.thickness
        });
    let thicknessSet = new Set();
    thicknessList.forEach(function (item) {
        thicknessSet.add({"id": item.id, "thickness": item.thickness})
    })

    let select = "";
    thicknessSet.forEach(function (item) {
        let selected = "";
        if (selectedOption.val() !== "") {
            if (item.id === (Number.parseInt(selectedOption.val()) || 0)) {
                selected = "selected";
            }
        }
        let option = "<option " + selected + " value=" + item.id + ">" + item.thickness + "</option>";
        select += option;
    })

    thicknessSelect.append(select);
}

function prepareProcessingType(glassRow, currentRow) {

    // let currentRow = $(glassRow).find('#processing>tr:last-child');
    let typeSelect = $(currentRow).find('#type');
    let selectedOption = $(typeSelect).find('option:selected');
    typeSelect.empty();

    processingTypesSet = new Set();
    processingList.forEach(function (item) {
        processingTypesSet.add(item.type)
    });

    let select = "";
    processingTypesSet.forEach(function (item) {
        let selected = "";
        if (selectedOption.val() !== "") {
            if (item === selectedOption.val()) {
                selected = "selected";
            }
        }
        let option = "<option " + selected + " value=" + item + ">" + messages['processing_' + item.toLowerCase()] + "</option>";
        select += option;
    });

    typeSelect.append(select);
    return typeSelect;
}

function prepareProcessingName(selected) {

    let currentType = selected.find('option:selected').val();
    let currentRow = selected.parents("#processing>tr");
    let nameSelect = $(currentRow).find('#name');
    let selectedOption = $(nameSelect).find('option:selected');
    nameSelect.empty();

    let processingNameList = processingList
        .filter(item => item.type === currentType);
    let processingSet = new Set();
    processingNameList.forEach(function (item) {
        processingSet.add({"id": item.id, "name": item.name})
    })

    let select = "";
    processingSet.forEach(function (item) {
        let selected = "";
        if (selectedOption.val() !== "") {
            if (item.id === (Number.parseInt(selectedOption.val()) || 0)) {
                selected = "selected";
            }
        }
        let option = "<option " + selected + " value=" + item.id + ">" + item.name + "</option>";
        select += option;
    })

    nameSelect.append(select);
}

function prepareAccessory(currentRow) {

    let accessorySelect = $(currentRow).find('#accessory');
    let selectedOption = $(accessorySelect).find('option:selected');
    accessorySelect.empty();

    let accessorySet = new Set();
    accessoryList.forEach(function (item) {
        accessorySet.add(item)
    });

    let select = "";
    accessorySet.forEach(function (item) {
        let selected = "";
        if (selectedOption.val() !== "") {
            if (item.id === (Number.parseInt(selectedOption.val() || 0))) {
                selected = "selected";
            }
        }
        let option = "<option " + selected + " value=" + item.id + ">" + item.name + "</option>";
        select += option;
    });

    accessorySelect.append(select);

    return accessorySelect;
}

///////////////////////

////Add rows////
function addGlassRow() {

    let tableBody = $('#glass');
    let currentRow = $('#glass>tr:last-child');

    let currentId = Number.parseInt(currentRow[0].id.split("_")[1]) || 0;
    let newRow = $(currentRow).clone().prop("id", "row_" + (currentId + 1));
    newRow.find("input").val("");
    newRow.find("#processing").empty();

    newRow.find('#glassType').change(function () {
        prepareThickness($(this));
    });

    newRow.find('#delete').click(function () {
        if ($(this).parents("tr")[0].id != "row_1") {
            $(this).parents("tr").remove();
        } else {
            showNotification(messages.firstRow, "warning")
        }
    });

    newRow.find('#addProcessing').click(function () {
        addProcessingRow($(this).parents("tr")[0]);
    });

    let select = newRow.find("#glassType");
    prepareThickness(select);

    tableBody.append(newRow);

}

function addProcessingRow(glassRow) {

    let tableProcessing = $(glassRow).find('#processing');
    let currentRow = $(glassRow).find('#processing>tr:last-child');
    let newRow;
    let type;
    if (currentRow.length === 0) {
        newRow = createProcessingRow();
        tableProcessing.append(newRow);

        let processingRow = $(glassRow).find('#processing>tr:last-child')
        type = prepareProcessingType(glassRow, processingRow);
    } else {
        let currentId = Number.parseInt(currentRow[0].id.split("_")[1]) || 0;
        newRow = $(currentRow).clone().prop("id", "row_" + (currentId + 1));
        newRow.find("input").val("");
        tableProcessing.append(newRow);

        type = newRow.find("#type");
    }

    prepareProcessingName(type);
    manageProcessingInputsVisibility(newRow);

    newRow.find('#type').change(function () {
        prepareProcessingName($(this));
        manageProcessingInputsVisibility($(this).parents('#processing>tr')[0]);
    });

    newRow.find('#delete').click(function () {
        $(this).parents("#processing>tr").remove();
    });
}

function addAccessoryRow() {

    let currentRow = $('#accessories>tr:last-child');
    let newRow;
    if (currentRow.length === 0) {
        newRow = createAccessoryRow();
    } else {
        let currentId = Number.parseInt(currentRow[0].id.split("_")[1]) || 0;
        newRow = $(currentRow).clone().prop("id", "row_" + (currentId + 1));
        newRow.find("input").val("");
    }

    prepareAccessory(newRow);

    newRow.find('#delete').click(function () {
        $(this).parents("#accessories>tr").remove();
    });

    $('#accessories').append(newRow);
}

function createProcessingRow() {

    let currentRow = $("<tr id='row_1'></tr>");

    currentRow.append('<td class="td-action">\n' +
        '<button type="button" id="delete" type="button" rel="tooltip"\n' +
        'class="btn btn-link btn-danger btn-sm btn-icon">\n' +
        '<i class="tim-icons icon-trash-simple"></i>\n' +
        '</button>\n' +
        '</td>');
    currentRow.append('<td>\n' +
        '<div class="form-row">\n' +
        '      <div class="form-group col-lg-6 col-md-12">\n' +
        '            <select class="form-control"\n' +
        '                  id="type">\n' +
        '           </select>\n' +
        '                   </div>\n' +
        '                   <div class="form-group col-lg-6 col-md-12">\n' +
        '                       <select class="form-control"\n' +
        '                               id="name">\n' +
        '                       </select>\n' +
        '                   </div>\n' +
        '               </div>\n' +
        '               <div class="form-row">\n' +
        '                   <div class="form-group col-lg-6 col-md-12">\n' +
        '                       <input class="form-control"\n' +
        '                              type="number"\n' +
        '                              id="quantity"\n' +
        '                              placeholder="' + messages.placeholderAmount + '">\n' +
        '                   </div>\n' +
        '               </div>\n' +
        '           </td>');

    return currentRow;
}

function manageProcessingInputsVisibility(currentRow) {

    let typeValue = $(currentRow).find("#type>option:selected").val();
    let quantity = $(currentRow).find("#quantity");

    if (typeValue === 'HOLE') {
        quantity.show();
    } else {
        quantity.hide();
    }
}

function createAccessoryRow() {

    let currentRow = $("<tr id='row_1'></tr>");

    currentRow.append('<td class="td-action">\n' +
        '<button type="button" id="delete" type="button" rel="tooltip"\n' +
        'class="btn btn-link btn-danger btn-sm btn-icon">\n' +
        '<i class="tim-icons icon-trash-simple"></i>\n' +
        '</button>\n' +
        '</td>');

    currentRow.append('<td>\n' +
        '     <div class="form-row">\n' +
        '          <div class="form-group col-lg-8 col-md-12">\n' +
        '                  <select class="form-control" id="accessory">\n' +
        '                  </select>\n' +
        '          </div>\n' +
        '          <div class="form-group col-lg-4 col-md-12">\n' +
        '                  <input class="form-control" id="amountAccessory"\n' +
        '                       placeholder="' + messages.placeholderAmount + '"\n' +
        '                       type="number"/>\n' +
        '           </div>\n' +
        '      </div>\n' +
        '</td>');

    return currentRow;

}

///////////

////// Create model
function createOrder() {

    let object = {};
    object['id'] = $("#id").val();
    object['productType'] = $("#productType>option:selected").val();
    object['cost'] = Number.parseFloat($("#cost").val()) || 0;
    object['installation'] = $("#installation").is(":checked");
    object['glassList'] = glassTable();
    object['accessories'] = accessoryTable();

    return object;
}

function createTemplate() {

    let object = {};
    object['id'] = $("#id").val();
    object['productType'] = $("#productType>option:selected").val();
    object['glassList'] = glassTable();
    object['accessories'] = accessoryTable();

    return object;
}

function glassTable() {

    let myRows = [];

    $('#glass>tr').each(function () {
        let obj = {}

        let type = {};
        type["id"] = $(this).find("#thickness>option:selected").val();
        type["name"] = $(this).find("#glassType>option:selected").val();
        type["thickness"] = Number.parseInt($(this).find("#thickness>option:selected").text());

        obj["type"] = type;
        obj["width"] = Number.parseInt($(this).find("#width").val()) || 0;
        obj["height"] = Number.parseInt($(this).find("#height").val()) || 0;
        obj["amount"] = Number.parseInt($(this).find("#amount").val()) || 1;
        obj["shape"] = $(this).find("#shape>option:selected").val();

        let tableProcessing = $(this).find("#processing>tr");
        let processingList = [];
        tableProcessing.each(function () {
                let processingObj = {};
                processingObj["type"] = $(this).find("#type>option:selected").val();
                processingObj["id"] = $(this).find("#name>option:selected").val();
                processingObj["name"] = $(this).find("#name>option:selected").text();
                processingObj["quantity"] = Number.parseInt($(this).find("#quantity").val()) || 0;

                processingList.push(processingObj);
            }
        )

        // obj["processingArrayList"] = processingList;
        obj["processingList"] = processingList;


        myRows.push(obj)
    });

    return myRows;

}

function accessoryTable() {

    let myRows = [];

    $('#accessories>tr').each(function () {
        let obj = {}

        let accessory = {};
        accessory["id"] = $(this).find("#accessory>option:selected").val();
        accessory["name"] = $(this).find("#accessory>option:selected").text();

        obj["component"] = accessory;
        obj["amount"] = Number.parseInt($(this).find("#amountAccessory").val()) || 1;

        myRows.push(obj)
    });

    return myRows;
}

////Save data////
function doAjaxCalculatePost() {
    // get the form values
    let Json = JSON.stringify(createOrder());
    $.ajax({
        type: "POST",
        url: "/calculator/calculate",
        contentType: "application/json",
        data: Json,
        success: function (response) {
            // we have the response
            if (response.status === "OK") {
                $('#cost').val(response.result);
                $('#costCart').text(response.result);
            } else {
                showNotification(messages['loadingData'], 'danger');
            }
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });
}

function doAjaxSaveOrderPost() {

    let Json = JSON.stringify(createOrder());
    $.ajax({
        type: "POST",
        url: "/order/",
        contentType: "application/json",
        data: Json,
        success: function (response) {
            if (response.status === "OK") {
                if (response.redirect) {
                    window.location.replace(response.redirectUrl);
                }
            } else {
                response.result.forEach(function (item) {
                    $('#error_' + item.field).text(messages[item.code]);
                    $('#' + item.field).addClass('form-control-danger');
                    $('#group_' + item.field).addClass('has-danger');
                });
            }
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });
}

function doAjaxSaveTemplatePost() {

    let Json = JSON.stringify(createTemplate());
    $.ajax({
        type: "POST",
        url: "/catalog/settings/",
        contentType: "application/json",
        data: Json,
        success: function (response) {
            if (response.status === "OK") {
                if (response.redirect) {
                    window.location.replace(response.redirectUrl);
                }
            } else {
                response.result.forEach(function (item) {
                    $('#error_' + item.field).text(messages[item.code]);
                    $('#' + item.field).addClass('form-control-danger');
                    $('#group_' + item.field).addClass('has-danger');
                });
            }
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });
}

function doAjaxAddToCartPost() {

    let order = createOrder();
    order.cost = Number.parseInt($('#costCart').text())||0;
    let Json = JSON.stringify(order);

    $.ajax({
        type: "POST",
        url: "/cart/add",
        contentType: "application/json",
        data: Json,
        success: function (response) {
            if (response.status === "OK") {
                showNotification(response.message, "success");
            } else {
                response.result.forEach(function (item) {
                    $('#error_' + item.field).text(messages[item.code]);
                    $('#' + item.field).addClass('form-control-danger');
                    $('#group_' + item.field).addClass('has-danger');
                });
            }
        },
        error: function (e) {
            showNotification(messages['loadingData'], 'danger');
        }
    });
}

