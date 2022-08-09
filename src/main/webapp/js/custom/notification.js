function showNotification(text, color) {
    $.notify({
        icon: "tim-icons icon-bell-55",
        message: text

    }, {
        type: color,
        timer: 8000,
        placement: {
            from: 'bottom',
            align: 'center'
        }
    });
}
