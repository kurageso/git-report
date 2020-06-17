<template>
  <v-app>
    <v-container>
      <v-row>
        <v-col cols="2">
          Git Report
          <v-text-field :value="input" @input="changeInput" />
        </v-col>
        <v-col cols="10">
          <v-list>
            <template v-for="(item, index) in pageItems">
              <div :key="index">
                <v-list-item ripple>
                  <v-list-item-icon>
                    <v-avatar color="info" size="40" tile>
                      <span class="white--text">{{ item.commit }}</span>
                    </v-avatar>
                  </v-list-item-icon>

                  <v-list-item-title>
                    <v-list-item-title>
                      {{ item.file }}
                    </v-list-item-title>
                    <v-list-item-subtitle>
                      <v-row align="start">
                        <v-col
                          v-for="(author, idx) in item.authors"
                          :key="idx"
                          v-show="idx < 2"
                          cols="3"
                          align-self="start"
                        >
                          <v-icon v-if="idx === 0">mdi-crown</v-icon>
                          {{ author.name }}
                          ( {{ author.commit }} )
                        </v-col>
                      </v-row>
                    </v-list-item-subtitle>
                  </v-list-item-title>
                </v-list-item>
                <v-divider inset class="my-0" />
              </div>
            </template>
          </v-list>
          <v-pagination v-model="page" :length="pageLength" :total-visible="7" />
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
import { readFileSync } from "fs";
import { extname } from "path";
import { safeLoad } from "js-yaml";
export default {
  data() {
    return {
      input: "",
      page: 1
    };
  },
  computed: {
    yaml() {
      const text = readFileSync("./report/result", "utf8");
      return safeLoad(text);
    },
    report() {
      if (this.input === "") {
        return this.yaml;
      } else {
        return this.yaml.filter(val => val.file.match(this.input));
      }
    },
    pageLength() {
      return Math.ceil(this.report.length / 10);
    },
    pageItems() {
      const start = this.page * 10 - 10;
      const end = this.page * 10 - 1;
      return this.report.slice(start, end);
    }
  },
  methods: {
    changeInput(val) {
      this.input = val;
      this.page = 1;
    }
  }
};
</script>

<style></style>
