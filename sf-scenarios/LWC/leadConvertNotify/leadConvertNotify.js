import { LightningElement, api } from 'lwc';
import convertAndNotify from '@salesforce/apex/LeadConvertControllerLWC2.convertAndNotify';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LeadConvertNotify extends LightningElement {

    @api recordId;

    handleClick() {
        convertAndNotify({ leadId: this.recordId })
        .then(() => {
            this.showToast('Success','Lead converted successfully','success');
        })
        .catch(error => {
            this.showToast('Error', error.body.message,'error');
        });
    }

    showToast(title,msg,variant){
        this.dispatchEvent(
            new ShowToastEvent({
                title:title,
                message:msg,
                variant:variant
            })
        );
    }
}