<template>
    <b-alert show>
        <h4 class="mb-1">
            <i class="fa fa-info-circle empty-message"></i>
            <span>{{ message | l }}</span>
        </h4>
        <p>
            <a href="#" @click.prevent="openGlobalUploadModal" v-localize>You can load your own data</a> or
            <a href="#" @click.prevent="clickDataLink" v-localize>get data from an external source</a>.
        </p>
    </b-alert>
</template>

<script>
import { openGlobalUploadModal } from "components/Upload";

export default {
    props: {
        message: { type: String, default: "This history is empty." },
    },
    methods: {
        openGlobalUploadModal,
        clickDataLink() {
            this.eventHub.$emit("openToolSection", "getext");
        },
    },
};
</script>
