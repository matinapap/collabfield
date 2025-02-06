$(document).on('turbolinks:load', function() {
    // When conversation heading is clicked, toggle conversation
    $('body').on('click', '.conversation-heading, .conversation-heading-full', function(e) {
        e.preventDefault();
        var panel = $(this).parent();
        var panel_body = panel.find('.panel-body');
        var messages_list = panel.find('.messages-list');

        panel_body.toggle(100, function() {
            // Check if there are any messages in the list
            var messages_visible = $('ul', this).has('li').length;

            // Load the first 10 messages if the list is empty
            if (!messages_visible && $('.load-more-messages', this).length) {
                // Click the 'load more messages' button to load the first 10
                $('.load-more-messages', this)[0].click(); 
            }
        });
    });

    var isLoading = false;
    var currentLoadingIcon;
    var iScrollPos = 0;

    // Handle scroll event inside conversation window
    $('.messages-list').on('scroll', function() {
        var iCurScrollPos = $(this).scrollTop();

        // Scroll down logic is not used here, only scrolling up
        if (iCurScrollPos < 300 && !isLoading && $('.load-more-messages', this).length) {
            // Trigger the "load more messages" link
            $('.load-more-messages', this)[0].click();
            isLoading = true;

            // Show loading icon
            currentLoadingIcon = $('.loading-more-messages', this);
            if (currentLoadingIcon.length) {
                currentLoadingIcon.show();
            }
        }

        // Save current scroll position
        iScrollPos = iCurScrollPos;
    });

    // Listen for AJAX completion and reset the loading flag
    $(document).on('ajax:complete', function() {
        isLoading = false;

        // Hide the loading icon when AJAX completes
        if (currentLoadingIcon !== undefined) {
            currentLoadingIcon.hide();
        }
    });
});
