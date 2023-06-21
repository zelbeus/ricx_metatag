$('body').fadeOut(0);
window.addEventListener('message', function(event) {
    switch (event.data.action) {
        case 'metatagui':
            $('body').empty();
            var data = $(event.data.data);
            $('body').append(data);
            $('body').fadeIn(0);

            $('.items').on('click', function() {
                var text = $(this).text();
                var $tempInput = $('<input>');
                $('body').append($tempInput);
                $tempInput.val(text).select();
                document.execCommand('copy');
                $tempInput.remove();
            });

            $('.picker').on('change', function() {
                var ped = $('#ped-id').val();
                var drawable = $('#drawable-name').val();
                var albedo = $('#albedo-name').val();
                var normal = $('#normal-name').val();
                var material = $('#material-name').val();
                var p1 = $('#p1-name').val();
                var p2 = $('#p2-name').val();
                var p3 = $('#p3-name').val();
                var p4 = $('#p4-name').val();
                console.log(p2)
                $.post('https://ricx_metatag/ricx_metatags:set_nui', JSON.stringify({ ped: ped, albedo: albedo, drawable: drawable, normal: normal, material: material, p1:p1, p2:p2,p3:p3,p4:p4}));
            });

            $('#submit-btn').click(function() {
                var ped = $('#ped-id').val();
                var drawable = $('#drawable-name').val();
                var albedo = $('#albedo-name').val();
                var normal = $('#normal-name').val();
                var material = $('#material-name').val();
                var p1 = $('#p1-name').val();
                var p2 = $('#p2-name').val();
                var p3 = $('#p3-name').val();
                var p4 = $('#p4-name').val();
                $.post('https://ricx_metatag/ricx_metatags:set_nui', JSON.stringify({ ped: ped, albedo: albedo, drawable: drawable, normal: normal, material: material, p1:p1, p2:p2,p3:p3,p4:p4}));
                NoMouse(1)
            });
            $('.search-bar1').on('input', function() {
                var searchTerm = $(this).val().toLowerCase();
                $('.menu-items1').each(function() {
                    var albedoText = $(this).text().toLowerCase();
                    if (albedoText.includes(searchTerm)) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            });
            $('.search-bar2').on('input', function() {
                var searchTerm = $(this).val().toLowerCase();
                $('.menu-items2').each(function() {
                    var albedoText = $(this).text().toLowerCase();
                    if (albedoText.includes(searchTerm)) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            });
            $('.search-bar3').on('input', function() {
                var searchTerm = $(this).val().toLowerCase();
                $('.menu-items3').each(function() {
                    var albedoText = $(this).text().toLowerCase();
                    if (albedoText.includes(searchTerm)) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            });
            document.addEventListener('keydown', InteractFocus);
            document.addEventListener('keydown', InteractClose);
            break;
        default:
            break;
    };
});
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
function NoMouse(s) {
    $('body').css('pointer-events', 'none');
    setTimeout(function() {
      $('body').css('pointer-events', 'auto');
    }, s * 1000);
}
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
function InteractClose(event) {
    if (event.key === 'Escape') {
        CloseMenu();
    }
}
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
function InteractFocus(event) {
    if (event.key === 'Enter') {
        $.post('https://ricx_metatag/ricx_metatags:focus');
    }
}

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
function CloseMenu() {
    $('#main').css({
        'animation': 'shrink-fade-out 1s forwards',
    });
    NoMouse(3)
    setTimeout(() => {
        $('body').fadeOut(500);
        $('body').empty();
    }, 1000);

    $.post('https://ricx_metatag/ricx_metatags:close');
}
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/