(function () {
    const searchInput = document.getElementById('search-input');
    const resultsContainer = document.getElementById('search-results');
    let searchData = [];

    if (!searchInput || !resultsContainer) return;

    // Fetch the search index
    fetch('/search.json')
        .then(response => response.json())
        .then(data => {
            searchData = data;
        })
        .catch(error => console.error('Error fetching search index:', error));

    searchInput.addEventListener('input', function () {
        const query = this.value.toLowerCase();
        resultsContainer.innerHTML = '';

        if (query.length < 2) {
            resultsContainer.style.display = 'none';
            return;
        }

        const filteredResults = searchData.filter(item => {
            return item.title.toLowerCase().includes(query) ||
                item.content.toLowerCase().includes(query);
        });

        if (filteredResults.length > 0) {
            resultsContainer.style.display = 'block';
            filteredResults.forEach(item => {
                const resultItem = document.createElement('div');
                resultItem.classList.add('search-result-item');

                const title = document.createElement('a');
                title.href = item.url;
                title.textContent = item.title;
                title.classList.add('search-result-title');

                const date = document.createElement('span');
                date.textContent = item.date;
                date.classList.add('search-result-date');

                resultItem.appendChild(title);
                resultItem.appendChild(date);
                resultsContainer.appendChild(resultItem);
            });
        } else {
            resultsContainer.style.display = 'block';
            resultsContainer.innerHTML = '<div class="search-no-results">No results found</div>';
        }
    });

    // Close search results when clicking outside
    document.addEventListener('click', function (e) {
        if (!searchInput.contains(e.target) && !resultsContainer.contains(e.target)) {
            resultsContainer.style.display = 'none';
        }
    });
})();
