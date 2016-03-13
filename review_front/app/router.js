import Ember from "ember";
import config from "./config/environment";

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route("projects");
  this.route("project", { path: "projects/:name/commits" });
  this.route("admin", function() {
    this.route("invitations", function() {
      this.route("index", { path: "/" });
      this.route("new");
    });
    this.route("users", function() {
      this.route("index", { path: "/" });
      this.route("edit", { path: "/:nickname" });
    });
  });
  this.route("404", { path: "/*path" });
});

export default Router;
