<template>
  <v-app>
    <v-card
      color="grey lighten-4"
      flat
      tile>
      <v-toolbar dense class="primary" :dark="true">
        <v-toolbar-title>
          <router-link to="/" class="toolbar-title" v-text="title" />
        </v-toolbar-title>
        <v-spacer />
        <div v-if="loggedIn">
          <v-btn
            color="white"
            text
            dark>
            {{ $auth.user.username }}
          </v-btn>
          <v-btn
            outlined
            color="white"
            text
            dark
            @click="logout()">
            ログアウト
          </v-btn>
        </div>
        <div v-else>
          <v-btn
            color="white"
            text
            dark
            @click="redirectLogin()">
            ログイン
          </v-btn>
        </div>
      </v-toolbar>
    </v-card>
    <v-main>
      <nuxt />
    </v-main>
    <v-footer center class="primary">
      <v-layout justify-center>
        <span class="text-white">&copy; RailsGym. All Rights Reserved.</span>
      </v-layout>
    </v-footer>
  </v-app>
</template>

<script>
export default {
  data () {
    return {
      title: 'RailsGym'
    }
  },
  computed: {
    loggedIn () {
      return this.$auth.loggedIn
    }
  },
  methods: {
    async logout () {
      try {
        await this.$auth.logout()
        await this.$apolloHelpers.onLogout()
        this.$toast.info('ログアウトしました')
        this.$router.push('/login')
      } catch (e) {
        console.log(e)
      }
    },
    redirectLogin () {
      this.$router.push('/login')
    }
  }
}
</script>
