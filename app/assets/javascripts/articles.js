$(function(){
  // loadTagData();
  // loadCategoryData();
});

function loadJSONData(url, successCallback) {
  $.ajax({
    url: url,
    async: true,
    dataType: 'json',
    type: 'GET',
    success: successCallback,
    error: function(jqXHR, textStatus, errorThrown) {
      console.log('error: ' + url + ' ' + errorThrown);
    }
  });

}

// function loadTagData() {
  // loadJSONData('/tags.json', processTagData);
// }

// function loadCategoryData() {
  // loadJSONData('/categories.json', processCategoryData);
// }

// function processTagData(data) {
  // data = normalizeTagData(data);
  // populateTagInput(data);
// }

// function processCategoryData(data) {
  // console.log('processCategoryData LOADED');
  // console.log(data);

  // data = normalizeCategoryData(data);
  // populateCategoryInput(data);
// }

// function normalizeTagData(tagData) {
  // var tagsObject = {
    // tags: []
  // };

  // for (var i=0; i < tagData.length; i++) {
    // tagsObject.tags.push(tagData[i].name);
  // }

  // return tagsObject;
// }

// function normalizeCategoryData(categoryData) {
  // var categoryObject = {
    // tags: []
  // };

  // for (var i=0; i < categoryData.length; i++) {
    // categoryObject.tags.push(categoryData[i].name);
  // }

  // return categoryObject;
// }

// function populateTagInput(tagData) {
  // $('#article_tags').select2({
    // tags: tagData.tags,
    // tokenSeparators: [" "]
  // });
// }

// function populateCategoryInput(categoryData) {
  // $('#article_category').select2({
    // tags: categoryData.tags,
    // tokenSeparators: [" "],
    // multiple: false
  // });
// }
