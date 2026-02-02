import { LightningElement, api, wire } from 'lwc';
import getCampaignMembers from '@salesforce/apex/OpportunityCampaignController.getCampaignMembers';

export default class OpportunityCampaignLWC extends LightningElement {

    @api recordId;
    campaignMembers;

    @wire(getCampaignMembers, { oppId: '$recordId' })
    wiredCampaigns({ data, error }) {
        if (data) {
            this.campaignMembers = data;
        }
    }

    handleSuccess(event) {

        const updatedFields = event.detail.fields;

        if (updatedFields.Amount && updatedFields.Amount.value > 50000) {

            const evt = new CustomEvent('highamount', {
                detail: updatedFields.Amount.value
            });

            this.dispatchEvent(evt);
        }
    }
}