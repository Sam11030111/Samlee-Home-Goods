document.addEventListener("click", (event) => {
    if (event.target && event.target.id === "clear-search") {
      const searchInput = document.getElementById("search-input");
  
      // Clear the input field
      searchInput.value = "";
  
      // Remove the query parameter from the URL
      const url = new URL(window.location.href);
      url.searchParams.delete("query");
  
      // Update the URL without refreshing
      window.history.pushState({}, "", url);
  
      // Reload the page to update results
      window.location.href = url;
    }
});