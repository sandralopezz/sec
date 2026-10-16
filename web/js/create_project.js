"use strict";

import { projectsAPI_auto } from "/js/api/_projects.js";
import { messageRenderer } from "/js/renderers/messages.js";
import { projectValidator } from "/js/validators/projects.js";
import { sessionManager } from "/js/utils/session.js";

let urlParams = new URLSearchParams(window.location.search);
let projectId = urlParams.get("projectId");
let currentProject = null;

async function main() {
    if (projectId !== null) {
        loadCurrentProject();
    }
    let registerForm = document.getElementById("form-project");
    registerForm.onsubmit = handleSubmitproject;
}

async function handleSubmitproject(event) {
    event.preventDefault();

    let form = event.target;
    let formData = new FormData(form);

    //VALIDACION
    let errors = projectValidator.validate(formData);
    document.getElementById("errors").innerHTML="";
    if (errors.length > 0){
        for (let error of errors){
            messageRenderer.showErrorMessage(error);
        }
        return;
    }

    // VALIDA USUARIO LOGUEADO
    if (currentProject === null) { 
        let logged = sessionManager.getLoggedUser();
        formData.append("userId", logged.userId);
        
        try {
            await projectsAPI_auto.create(formData);
            //let newId = resp.lastId;
            window.location.href = `projects.html`;
        } catch (err) {
            messageRenderer.showErrorMessage(err.response.data.message);
        }
    } else { // Updating an existing project
            formData.append("userId", currentProject.userId);
            //formData.append("date", currentProject.date);

             try {
                await projectsAPI_auto.update(formData, projectId);
                window.location.href = `create_project.html?projectId=${projectId}`;
            } catch (err) {
                messageRenderer.showErrorAsAlert(err.response.data.message);
            }
    }
}

async function loadCurrentProject() {
    let nameInput = document.getElementById("input-name");
    let descriptionInput = document.getElementById("input-description");
    let projectLeaderInput = document.getElementById("input-projectLeader");
    let budgetInput = document.getElementById("input-budget");
    let startingDateInput = document.getElementById("input-startingDate");
    let endingDateInput = document.getElementById("input-endingDate");
    let imageUrlInput = document.getElementById("input-imageUrl");

    //pageTitle.textContent = "Editing a Project";

    try {
        currentProject = await projectsAPI_auto.getById(projectId);
        nameInput.value = currentProject.name;
        descriptionInput.value = currentProject.description;
        projectLeaderInput.value = currentProject.projectLeader;
        budgetInput.value = currentProject.budget;
        startingDateInput.value = currentProject.startingDate;
        endingDateInput.value = currentProject.endingDate;
        imageUrlInput.value = currentProject.imageUrl;

    } catch (err) {
        messageRenderer.showErrorMessage(err.response.data.message);
    }
}


document.addEventListener("DOMContentLoaded", main);
