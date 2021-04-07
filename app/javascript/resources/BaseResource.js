import APILibrary from "./APILibrary";

export const PAGE_SIZE = 10;

class Base extends APILibrary.Base {
  post(action, callback) {
    this.errors().reset();

    this.klass()
      .resourceLibrary.interface.post(`${this.__links.self}/${action}`, this)
      .then(callback, callback);
  }

  static toUnderscore(text) {
    return text
      .split(/(?=[A-Z])/)
      .join("_")
      .toLowerCase();
  }

  getErrors() {
    const output = {};
    const backendErrors = this.__errors.__errors;
    const toUnderscore = this.klass().toUnderscore;

    Object.keys(backendErrors).forEach(key => {
      const errors = [];
      backendErrors[key].forEach(value => {
        errors.push(
          value.message.replace(`${toUnderscore(value.field)} - `, "")
        );
      });

      output[key] = errors.toString();

      // TODO Find a way to handle erros when have relationships
      output[`${key}Id`] = errors.toString();
    });

    return output;
  }

  getErrorsAsString() {
    const output = {};
    const backendErrors = this.__errors.__errors;
    const toUnderscore = this.klass().toUnderscore;

    Object.keys(backendErrors).forEach(key => {
      const errors = [];
      backendErrors[key].forEach(value => {
        errors.push(
          value.message.replace(`${toUnderscore(value.field)} - `, "")
        );
      });
      output[key] = errors.toString();
    });

    return Object.values(output).join(", ");
  }

  static async list(params) {
    const { page, ...filters } = params;

    const res = await this.where(filters)
      .order({ updatedAt: "desc" })
      .perPage(PAGE_SIZE)
      .page(page)
      .all();

    return res;
  }
}

export default Base;
