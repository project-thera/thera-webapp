import Vue from "vue";

Vue.prototype.$setFileData = async function(
  file,
  object,
  attribute,
  validate = null
) {
  if (file) {
    let result = { valid: true };

    if (validate) {
      result = await validate(file);
    }

    if (result.valid) {
      const reader = new FileReader();

      reader.onloadend = function(event) {
        object[attribute] = event.target.result;
      };

      reader.readAsDataURL(file);
    }
  }
};
