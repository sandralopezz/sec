"use strict";

const projectValidator = {

    validate: function (formData) {
    let errors = [];

        let name = formData.get("name");
        let projectLeader = formData.get("projectLeader");
        let budget = formData.get("budget");
        let startingDate = formData.get("startingDate");
        let endingDate = formData.get("endingDate");
        let numBudget = Number(budget);

        if (!name || !projectLeader || !budget || !startingDate || !endingDate) {
            errors.push("Todos los campos son obligatorios");
        }

        if (projectLeader && (projectLeader.length == 0 || projectLeader.length % 5 != 0)) {
            errors.push("Project Leader multiplo de 5");
        }

        if (budget && (numBudget < 1000 || numBudget > 1000000)){
            errors.push("El valor budget debe estar entre 1000 y 1000000");
        }

    return errors;
    }

};

export { projectValidator };
