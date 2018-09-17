$(document).ready(function() {
    $('.js-edit-desc').off('click').click(function(e) {
        e.preventDefault();

        var album_id = $(this).data('album-id'),
            id = $(this).data('id'),
            desc = $(this).data('desc') || '';

        var text = prompt('Enter the description', desc);
        if (text === null) {
            return;
        }

        if (text.length > 24) {
            alert('Too long description. Max: 24 characters');
            return;
        }

        $.ajax({
            type: "PATCH",
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            url: $(this).attr('href'),
            data: { photo: {
                    title: text
                } },
            success: function() { location.reload() },
            error: function() { location.reload() }
        });
    });

});