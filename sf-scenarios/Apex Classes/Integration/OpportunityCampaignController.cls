public with sharing class OpportunityCampaignController {

    @AuraEnabled(cacheable=true)
    public static List<CampaignMember> getCampaignMembers(Id oppId) {

        return [
            SELECT Id, Contact.Name, Campaign.Name
            FROM CampaignMember
            WHERE CampaignId IN (
                SELECT CampaignId
                FROM Opportunity
                WHERE Id = :oppId
            )
            LIMIT 10
        ];
    }
}