package io.lippia.api.lowcode.steps

import com.sun.org.apache.xalan.internal.xsltc.compiler.util.Type.Root
import gherkin.deps.com.google.gson.Gson
import io.cucumber.java.en.And
import io.lippia.api.lowcode.variables.VariablesManager

class MyStepdefs {

    @And("defino una variable con nombre (.*) que contenga el id de workspace cuyo nombre es (.*)")
    public void setVariable(String key, String value) {
        Gson gson = new Gson();
        Workspace [] listWorkspaces = gson.fromJson((String) APIManager.getLastResponse().getResponse(), Root[].class);
        for (Root element : listWorkspaces){
            if (element.getName().equalsIgnoreCase(value)){
                VariablesManager.setVariable(key, element.getId());
            }
        }
    }
}