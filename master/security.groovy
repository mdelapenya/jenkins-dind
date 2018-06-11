#!groovy
 
import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule
import org.jenkinsci.plugins.scriptsecurity.scripts.*

def instance = Jenkins.getInstance()
 
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "passw0rd")
instance.setSecurityRealm(hudsonRealm)
 
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()
 
Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)

ScriptApproval sa = ScriptApproval.get(); 

def signature = "new net.sf.json.JSONObject"
sa.getPendingSignatures().add(new ScriptApproval.PendingSignature(signature, false, ApprovalContext.create()))

signature = "new net.sf.json.JSONArray"
sa.getPendingSignatures().add(new ScriptApproval.PendingSignature(signature, false, ApprovalContext.create()))

// approve signatures
for (ScriptApproval.PendingSignature pending : sa.getPendingSignatures()) {
   if (pending.equals(signature)) {
       	sa.approveSignature(pending.signature);
     	println "Approved : " + pending.signature
      }
}
