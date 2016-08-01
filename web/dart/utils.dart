/*
 * Tangible Spark
 */
part of TangibleSpark;


/**
 * Binds a click event to a button
 */
void bindClickEvent(String id, Function callback) {
  Element el = querySelector("#${id}");
  if (el != null) {
    el.onMouseUp.listen(callback);
  }
}


/**
 * Adds a class to a DOM element
 */
void addHtmlClass(String id, String cls) {
  Element el = querySelector("#${id}");
  if (el != null) {
    el.classes.add(cls);
  }
}


/**
 * Removes a class from a DOM element
 */
void removeHtmlClass(String id, String cls) {
  Element el = querySelector("#${id}");
  if (el != null) {
    el.classes.remove(cls);
  }
}


/**
 * Sets the inner HTML for the given DOM element 
 */
void setHtmlText(String id, String text) {
  Element el = querySelector("#${id}");
  if (el != null) {
    el.innerHtml = text;
  }
}


/*
 * Sets the visibility state for the given DOM element
 */
void setHtmlVisibility(String id, bool visible) {
  Element el = querySelector("#${id}");
  if (el != null) {
    el.style.visibility = visible ? "visible" : "hidden";
  }
}


/*
 * Sets the opacity state for the given DOM element
 */
void setHtmlOpacity(String id, double opacity) {
  Element el = querySelector("#${id}");
  if (el != null) {
    el.style.opacity = "${opacity}";
  }
}


/*
 * Sets teh background image for the given DOM element
 */
void setBackgroundImage(String id, String src) {
  Element el = querySelector("#${id}");
  if (el != null) {
    el.style.backgroundImage = "url('${src}')";
  }
}

