<aura:application extends="force:slds" controller="ContactController">
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <lightning:button variant="brand" label="Submit" aura:id="submit" onclick="{! c.showMessage }" />
     <!--<aura:attribute name="record" type="Contact" default="{ 'sobjectType': 'Contact' }"/>
    <aura:attribute name="obj" type="Contact" default="{ 'sobjectType': 'Contact' }"/>
	<aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <c:DynamicCreationComp />
        <lightning:card title="Card Header" iconName="custom:custom47" >
    </lightning:card>
   <c:LightningDataServices />
    <force:recordData aura:id="forceRecordCmp"  recordId="0037F00000UVWNq" layoutType="FULL"  mode="EDIT" targetRecord="{!v.obj}" targetFields="{!v.record}"   />
    <div class="recordName">
        <p class="slds-text-heading__medium">
             <force:inputField value="{!v.record.LastName}"/>
   			 <force:inputField value="{!v.record.AccountId}"/>

        </p>
    </div>
    <button onclick="{!c.recordSaved}">Save</button>
    <lightning:progressIndicator currentStep="step2">
        <lightning:progressStep label="Step One" value="step1" onclick="{!c.handleClicked}"/>
        <lightning:progressStep label="Step Two" value="step2" onclick="{!c.handleClicked}"/>
        <lightning:progressStep label="Step Three" value="step3" onclick="{!c.handleClicked}"/>
    </lightning:progressIndicator>
   
<ltng:require scripts="/resource/jqueryNew,/resource/jqueryUI"  afterScriptsLoaded="{!c.scriptsLoaded}"/>  
<aura:attribute name="empname" type="String" default="newOrg"/>
    <aura:attribute name="fields" type="String[]" default="['Account']"/>
    <aura:iteration items="{!v.fields}" var="field">
    <c:testComp aura:id="test" Obj="{!field}"/>
    </aura:iteration>
   <button onclick="{!c.recordSaved}">Save</button>
    <force:recordEdit aura:id="edit" recordId="0037F00000UVWNq" />  
    <button onclick="{!c.recordSaved}">Save</button>-->
    <!--
    -->
<!--  <c:ContactDatatable /> <c:tree /> <c:testComp onclick="{!c.showMessage}"/> 
    <div id="dv1" >
       <ui:button aura:id="button" buttonTitle="Click to see what you put into the field" class="button" label="Click me" press="{!c.getDetails}"/>
    </div>
     <lightning:helptext content="Your email address will be your login name" />
    <lightning:layout horizontalAlign="space">
            <lightning:layoutItem flexibility="auto" padding="around-small">
                1
            </lightning:layoutItem>
            <lightning:layoutItem flexibility="auto" padding="around-small">
                2
            </lightning:layoutItem>
            <lightning:layoutItem flexibility="auto" padding="around-small">
                3
            </lightning:layoutItem>
            <lightning:layoutItem flexibility="auto" padding="around-small">
                4
            </lightning:layoutItem>
        </lightning:layout>
  
    <c:AddtnalMetadata addMDModalVisible="true" sfOrgName="newOrg"/>
    
     <c:DXEZCommitLabel />
    <lightning:progressIndicator type="path" currentStep="step2" variant="base">
        <lightning:progressStep label="Step One" value="step1" title="Step One"/>
        <lightning:progressStep label="Step Two" value="step2" title="Step Two"/>
        <lightning:progressStep label="Step Three" value="step3" title="Step Three"/>
    </lightning:progressIndicator>
    <aura:handler name="init" value="{! this }" action="{! c.initialize }"/>
     <div style="height: 300px;">
        <c:ContactDatatable />
    <aura:attribute name="htmlstr" type="String" />
    <aura:attribute name="listOptions" type="List" default="[]"/>
    <aura:attribute name="defaultOptions" type="List" default="[]"/>
    <aura:attribute name="requiredOptions" type="List" default="[]"/>
    <aura:handler name="init" value="{! this }" action="{! c.initialize }"/>
    <lightning:dualListbox aura:id="selectOptions" name="Select Options"  label="Select Options" 
                           sourceLabel="Available Options" 
                           selectedLabel="Selected Options" 
                           options="{! v.listOptions }"
                           value="{! v.defaultOptions }"
                           requiredOptions="{! v.requiredOptions }"
                           onchange="{! c.handleChange }"/>
    <lightning:textarea name="myTextArea" value="initial value" label="What are you thinking about?" maxlength="300" />
    <aura:unescapedHtml value="{!v.htmlstr}"/>
    {!$Label.c.DX_API}
    <aura:attribute name="text" type="String" default="Hai"/>
    <ui:inputText value="{!v.text}"/>
    <div aura:id="main" id="main">
    
    </div>
    <button onclick="{!c.setData}">click</button>
    <c:ConfirmDeleteScratchOrg />-->
</aura:application>