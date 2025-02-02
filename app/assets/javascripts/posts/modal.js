$(document).ready(function() {
  // When a post is clicked, show its full content in a modal window
  $("body").on("click", ".single-post-card, .single-post-list", function() {
    var posted_by = $(this).find('.post-content .posted-by').html();
    var post_heading = $(this).find('.post-content h3').html();
    var post_content = $(this).find('.post-content p').html();
    var post_id = $(this).data('post-id'); // Assuming you have a data-post-id on the post element
    var interested_url = "/posts/" + post_id; 

    // Update modal with post data
    $('.modal-header .posted-by').text(posted_by);
    $('.loaded-data h3').text(post_heading);
    $('.loaded-data p').text(post_content);
    $('.loaded-data .interested a').attr('href', interested_url); 
    
    // Show the modal
    $('.myModal').modal('show');
  });
});
