<template>
    <PriorityMenu :starting-height="27">
        <PriorityMenuItem
            key="select-new-history"
            title="Select History"
            icon="fa fa-folder-open"
            @click="$emit('selectHistoryModal')"
        />
        <PriorityMenuItem
            key="create-new-history"
            title="Create New History"
            class="history-new-button"
            icon="fa fa-plus"
            @click="$emit('createNewHistory')"
        />
        <PriorityMenuItem
            key="view-all-histories"
            title="View All Histories"
            icon="fa fa-columns"
            class="history-view-multi-button"
            @click="redirect('/history/view_multiple')"
        />
        <PriorityMenuItem
            key="saved-histories"
            title="Saved Histories"
            icon="fas fa-save"
            @click="backboneRoute('/histories/list')"
        />
        <PriorityMenuItem
            key="clear-history-cache"
            title="Refresh History"
            icon="fa fa-refresh"
            class="history-refresh-button"
            @click.stop="clearCache"
        />
        <PriorityMenuItem
            key="use-legacy-history"
            title="Return to legacy history panel"
            icon="fas fa-exchange-alt"
            @click="switchToLegacyHistoryPanel"
        />
    </PriorityMenu>
</template>

<script>
import { PriorityMenuItem, PriorityMenu } from "components/PriorityMenu";
import { wipeDatabase, clearHistoryDateStore } from "./caching";
import { legacyNavigationMixin } from "components/plugins/legacyNavigation";
import { switchToLegacyHistoryPanel } from "./adapters/betaToggle";
import { reloadPage } from "utils/redirect";

export default {
    mixins: [legacyNavigationMixin],
    components: {
        PriorityMenu,
        PriorityMenuItem,
    },
    methods: {
        async clearCache() {
            await wipeDatabase();
            await clearHistoryDateStore();
            reloadPage();
        },
        switchToLegacyHistoryPanel,
    },
};
</script>
