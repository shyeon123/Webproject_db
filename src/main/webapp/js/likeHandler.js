document.getElementById('likeButton').addEventListener('click', function() {
    const postId = document.querySelector('input[name="post_id"]').value;
    
    fetch('likePost.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `post_id=${postId}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            const likesCountElement = document.getElementById('likesCount');
            likesCountElement.textContent = data.likesCount;
        } else if (data.status === 'alreadyLiked') {
            alert('이미 좋아요를 누르셨습니다.');
        } else {
            alert('좋아요 처리에 실패했습니다.');
        }
    })
    .catch(error => console.error('Error:', error));
});
