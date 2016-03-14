import Ember from "ember";

export default Ember.Controller.extend({
  queryParams: ["page", "query"],
  totalPagesBinding: "model.totalPages",
  page: 1,
  query: "",
  actions: {
    pageClicked(page) {
      this.setProperties({ page });
    },
    searchInputChanged(value) {
      this.set("page", 1);
      this.set("query", value);
    }
  }
});
