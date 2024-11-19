document.getElementById('checkDuplicateBtn').addEventListener('click', function() {
    const userId = document.getElementById('user_Id').value;

    if (!userId.trim()) {
        document.getElementById('duplicateCheckResult').textContent = "아이디를 입력하세요.";
        return;
    }

    fetch(`checkDuplicate.jsp?user_id=${encodeURIComponent(userId)}`)
        .then(response => response.text())
        .then(data => {
            document.getElementById('duplicateCheckResult').textContent = data;
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('duplicateCheckResult').textContent = "중복체크에 실패했습니다. 다시 시도해주세요.";
        });
});
/**
 * 
 */