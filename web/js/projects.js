"use strict";

import { projectRenderer } from "/js/renderers/projects.js";
import { messageRenderer } from "/js/renderers/messages.js";
import { projectswithusersAPI_auto } from "/js/api/_projectswithusers.js";

async function main() {
    loadAllprojects();
}

async function loadAllprojects() {
    let projectsContainer = document.querySelector("div.container");
    
    try {
        //GET ALL PARA COGER INFO DE LOS USUARIOS
        let projects = await projectswithusersAPI_auto.getAll();
        //RECORREMOS LOS PROJECTS
        for (let project of projects){
            projectsContainer.appendChild(projectRenderer.asCard(project));
        }
    } catch (err) {
        messageRenderer.showErrorMessage("Error while loading projects", err);
    }
}

document.addEventListener("DOMContentLoaded", main);

