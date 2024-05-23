Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6119BC41513
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 14:53:47 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.595.1716476026490132048
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 07:53:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=QradZLBY;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.208.47, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so12969941a12.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1716476025; x=1717080825; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S4lpPe0UFClaodcxvB70T8RmSHyDYRqy/PirT9zFX7g=;
        b=QradZLBYjb9MxSqzT7aGYbitwuHcnNkfOVWOleejff9Ni0mJHPVjI2TUh2pFB/eZUN
         t6FMRfRTfSRkNUtG1fpXcFnt9S4OMGCKed7tfXw65sKy0mRIYz+oSTpSzGFtlQsD34mg
         VvYLrm0cF5VZrdyqxSOTHmhBsqVgqH2GubxHp1GQGKVcw470R14kODHN0ii3WNlLn6su
         PTrz0y+0t+1zf4nMMzM3pscXZXlZXLce0XsO3p8ZG5HT6q0SBkq4jUanls+rmnVDVf3j
         fQ4+CejJ/fA25L5RbGSA2S2NKhhnZ7F+J6/xygNUFeIAAxffZZzmD8ycOAJl+JQhv/0z
         iWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476025; x=1717080825;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4lpPe0UFClaodcxvB70T8RmSHyDYRqy/PirT9zFX7g=;
        b=Vm5It4sSOLH0XafXS0lxRrRrK/fjtIJlqNb+Y8POtcSrBXb3HIrNWFvn/3lOO+RPZx
         gPvrGaR2u17+vxtxQW0LhFjeUcfkr70Stae7cL+4N7y0oDGYTcdLGM2PkghCF1dnGPhM
         Hx1/qOMshc7pbHa8zk+ljW7B1h7i37AK9uRuJli3rfOvAOuUMLNDW2hc0+sTYASAZy76
         QveQpNPOIfaDroKnbYmAjGZBj557t9ZwlODvIrGuwuULSYXud6BBxg3BAbYvKnLs6OyV
         uOkdKZmxIOiY1z6KRYohzg0no6DH5vNZIktiydFoaiTdznIZ6f3kQ6b0ht1Pnwtqabb1
         fK7w==
X-Gm-Message-State: AOJu0YybSr1pi5wg5ZkRn0wv2d/kMEUZY8syFoNK9QXKVmLISEgdOvlY
	0tsUoP6qPa6AxAlZrCZBCHXCjnUBS8Di9NtfBe7NIhVaCXBTR2lyLJOZstaIUPHletJbGe6Rfhh
	j5y0=
X-Google-Smtp-Source: AGHT+IF6Bxef2jRt5iXYNXBCFU8xu/9mbNxMDgiUUIPjP+/44uLCtnmTVD4eQ6/Oth27zCzwwbY1OA==
X-Received: by 2002:a50:9e2d:0:b0:572:9962:7f0 with SMTP id 4fb4d7f45d1cf-57832c51110mr3053398a12.34.1716476024760;
        Thu, 23 May 2024 07:53:44 -0700 (PDT)
Received: from localhost.localdomain ([62.72.77.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322c06sm20394959a12.85.2024.05.23.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:53:44 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	=?UTF-8?q?Alba=20Herrer=C3=ADas?= <albaherreriasdev@gmail.com>,
	Ninette Adhikari <13760198+ninetteadhikari@users.noreply.github.com>
Subject: [PATCH 1/1] scripts/generate-testresult-index.py: index of autobuilder test results improvements
Date: Thu, 23 May 2024 16:53:31 +0200
Message-ID: <20240523145331.49565-2-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523145331.49565-1-ninette@thehoodiefirm.com>
References: <20240523145331.49565-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 14:53:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/181

From: Alba Herrerías <albaherreriasdev@gmail.com>

- Added pico.css to make CSS improvements
- Added filters to the table for better readability of the test results. Filters were added for build type, branch and date
- Added pagination, which improved the performance of the website
- The html index template has been added as a separate file for better maintainability

Co-Authored-By: Ninette Adhikari <13760198+ninetteadhikari@users.noreply.github.com>
---
 scripts/generate-testresult-index.py | 103 +++----
 scripts/index-table.html             | 401 +++++++++++++++++++++++++++
 2 files changed, 439 insertions(+), 65 deletions(-)
 create mode 100644 scripts/index-table.html

diff --git a/scripts/generate-testresult-index.py b/scripts/generate-testresult-index.py
index 61b684a..568154d 100755
--- a/scripts/generate-testresult-index.py
+++ b/scripts/generate-testresult-index.py
@@ -13,68 +13,6 @@ import re
 import subprocess
 from jinja2 import Template
 
-index_template = """
-<!DOCTYPE html>
-<html>
-<head>
-  <meta charset="utf-8">
-  <meta name="viewport" content="width=device-width, initial-scale=1">
-  <title>Index of autobuilder test results</title>
-  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
-</head>
-<body>
- 
-<table class="table is-narrow is-striped">
-<thead>
-<tr>
-  <th>Build</th>
-  <th>Type</th>
-  <th>Branch</th>
-  <th>Test Results Report</th>
-  <th>Performance Reports</th>
-  <th>ptest Logs</th>
-  <th>Buildhistory</th>
-  <th>Host Data</th>
-</tr>
-</thead>
-<tdata>
-{% for entry in entries %}
-<tr>
-   <td><a href="{{entry[1]}}">{{entry[0]}}</a></td>
-   <td>{% if entry[2] %} {{entry[2]}}{% endif %}</td>
-   <td>{% if entry[4] %} {{entry[4]}}{% endif %}</td>
-   <td>
-     {% if entry[3] %}<a href="{{entry[3]}}">Report</a>{% endif -%}
-     {% if entry[9] %}<br><a href="{{entry[9]}}">Regressions</a>{% endif %}
-   </td>
-   <td>
-   {% for perfrep in entry[6] %}
-     <a href="{{perfrep[0]}}">{{perfrep[1]}}</a>
-   {% endfor %}
-   </td>
-   <td>
-   {% for ptest in entry[7] %}
-     <a href="{{ptest[0]}}">{{ptest[1]}}</a>
-   {% endfor %}
-   </td>
-   <td>
-   {% for bh in entry[5] %}
-     <a href="{{bh[0]}}">{{bh[1]}}</a>
-   {% endfor %}
-   </td>
-   <td>
-   {% for hd in entry[8] %}
-     <a href="{{hd[0]}}">{{hd[1]}}</a>
-   {% endfor %}
-   </td>
-</tr>
-{% endfor %}
-</tdata>
-</table>
-</body>
-</html>
-"""
-
 def parse_args(argv=None):
     """Parse command line arguments"""
     parser = argparse.ArgumentParser(
@@ -88,6 +26,9 @@ def parse_args(argv=None):
 args = parse_args()
 path = os.path.abspath(args.path)
 entries = []
+filter_items = dict()
+build_types = set()
+branch_list= set()
 
 def get_build_branch(p):
     for root, dirs, files in os.walk(p):
@@ -175,7 +116,34 @@ for build in sorted(os.listdir(path), key=keygen, reverse=True):
 
     branch = get_build_branch(buildpath)
 
-    entries.append((build, reldir, btype, testreport, branch, buildhistory, perfreports, ptestlogs, hd, regressionreport))
+    build_types.add(btype)
+    if branch: branch_list.add(branch)
+    # Creates a dictionary of items to be filtered for build types and branch
+    filter_items["build_types"] = build_types
+    filter_items["branch_list"] = branch_list
+
+    entry = {
+        'build': build, 
+        'btype': btype,
+        'reldir': reldir 
+    }
+
+    if testreport:
+        entry['testreport'] = testreport
+    if branch:
+        entry['branch'] = branch
+    if buildhistory:
+        entry['buildhistory'] = buildhistory
+    if perfreports:
+        entry['perfreports'] = perfreports
+    if ptestlogs:
+        entry['ptestlogs'] = ptestlogs
+    if hd:
+        entry['hd'] = hd
+    if regressionreport:
+        entry['regressionreport'] = regressionreport
+
+    entries.append(entry)
 
     # Also ensure we have saved out log data for ptest runs to aid debugging
     if "ptest" in btype or btype in ["full", "quick"]:
@@ -191,6 +159,11 @@ for build in sorted(os.listdir(path), key=keygen, reverse=True):
                     with open(f + "/resulttool-done.log", "a+") as tf:
                         tf.write("\n")
 
-t = Template(index_template)
+with open("./index-table.html") as file_:
+    t = Template(file_.read())
+
+with open(os.path.join(path, "data.json"), 'w') as f:
+    json.dump(entries, f)
+
 with open(os.path.join(path, "index.html"), 'w') as f:
-    f.write(t.render(entries = entries))
+    f.write(t.render(entries = entries, filter_items = filter_items))
diff --git a/scripts/index-table.html b/scripts/index-table.html
new file mode 100644
index 0000000..e0d819d
--- /dev/null
+++ b/scripts/index-table.html
@@ -0,0 +1,401 @@
+<!DOCTYPE html>
+<html>
+  <head>
+    <meta charset="utf-8" />
+    <meta name="viewport" content="width=device-width, initial-scale=1" />
+    <title>Index of autobuilder test results</title>
+    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css" />
+    <style>
+      :root {
+        font-size: 16px;
+      }
+      .no-wrap {
+        white-space: nowrap;
+      }
+      .type-select {
+        align-items: center;
+        background-color: white;
+        display: flex;
+        position: sticky;
+        top: 0px;
+      }
+      .type-select label {
+        margin-right: 20px;
+        flex-shrink: 0;
+      }
+      .type-select select {
+        max-width: 300px;
+      }
+      table tr:nth-child(even) td {
+        background-color: rgba(111, 120, 135, 0.0375);
+      }
+      table tr td:not(:last-child) {
+        border-right: 0.0625rem solid #e7eaf0;
+      }
+      a {
+        cursor: pointer;
+      }
+      .hide {
+        visibility: hidden;
+      }
+    </style>
+  </head>
+
+  <body onload="mount()">
+    <header class="container">
+      <h1>Index of autobuilder test results</h1>
+      <p>The table below lists the test results of all the builds and branch from the yocto autobuilder repository.</p>
+      <p>The filters for showing build types and branch helps to navigate the table.</p>
+    </header>
+    <main class="container">
+    <nav class="type-select">
+      <ul>
+        <li>
+          <label for="build-type-select">Filter by type:</label>
+            <select id="build-type-select" class="hide" onchange="setFilterParams()">
+              <option value="all">Type (all)</option>
+              {% for type in filter_items.build_types %}
+                <option value="{{type}}">{{type}}</option>
+              {% endfor %}
+            </select>
+        </li>
+        <li>
+          <label for="branch-select">Filter by branch:</label>
+          <select id="branch-select" class="hide" onchange="setFilterParams()">
+            <option value="all">Branch (all)</option>
+            {% for branch in filter_items.branch_list %}
+              <option value="{{branch}}">{{branch}}</option>
+            {% endfor %}
+          </select>
+        </li>
+        <li>
+          <label for="date-filter">Filter by date:</label>
+          <input id="date-filter" type="date" name="date" aria-label="Date" onchange="setFilterParams()" />
+        </li>
+      </ul>
+      <ul class="pagination-nav"></ul>
+    </nav>
+
+    <table class="test-table hide">
+      <thead>
+      <tr>
+        <th>Build</th>
+        <th>Type</th>
+        <th>Branch</th>
+        <th>Test Results Report</th>
+        <th>Performance Reports</th>
+        <th>ptest Logs</th>
+        <th>Buildhistory</th>
+        <th>Host Data</th>
+      </tr>
+      </thead>
+      <tbody></tbody>
+    </table>
+
+    <p id="error-message"></p>
+  </main>
+</body>
+</html>
+
+<script type="text/javascript">
+  let entries = []
+  let rowsPerPage = 50
+  let currentPage = 0
+  const pageWidth = 6
+  const tbody = document.getElementsByTagName('tbody')[0]
+  let params
+
+  async function loadEntries() {
+    try {
+      const response = await fetch('data.json')
+      const data = await response.json()
+      if (areFiltersSet()) {
+        entries = setFilteredData(data)
+      } else {
+        entries = data
+      }
+    } catch (error) {
+      console.error('Error loading entries', error)
+    }
+  }
+
+  function setFilteredData(data) {
+    const { type, branch, date } = getParams()
+
+    return data.filter(entry => {
+      return (entry.btype === type || !type) && (entry.branch === branch || !branch) && (!date || areDatesEqual(entry.build, date))
+    })
+  }
+
+  function getParams() {
+    let params = new URL(document.location.toString()).searchParams
+    let page = params.get('page')
+    let type = params.get('type')
+    let branch = params.get('branch')
+    let date = params.get('date')
+    if (!page) {
+      page = 0
+    }
+    currentPage = parseInt(page)
+    return { page, type, branch, date }
+  }
+
+  function areFiltersSet() {
+    const { type, branch, date } = getParams()
+    if (!type && !branch && !date) {
+      return false
+    }
+    return true
+  }
+
+  async function setFilterParams() {
+    const build_type_value = document.getElementById('build-type-select').value
+    const branch_value = document.getElementById('branch-select').value
+    const date_value = document.getElementById('date-filter').value
+
+    if (build_type_value) {
+      if (build_type_value === 'all') {
+        params.delete('type')
+      } else {
+        params.set('type', build_type_value)
+      }
+    }
+    if (branch_value) {
+      if (branch_value === 'all') {
+        params.delete('branch')
+      } else {
+        params.set('branch', branch_value)
+      }
+    }
+    if (date_value) {
+      params.set('date', date_value)
+    } else {
+      params.delete('date')
+    }
+
+    window.location.search = params
+  }
+
+  function areDatesEqual(build, inputDate) {
+    if (!inputDate) {
+      return false
+    }
+    const buildDate = build.substring(0, build.indexOf('-'))
+    const date = inputDate.replaceAll('-', '')
+
+    if (buildDate === date) {
+      return true
+    }
+
+    return false
+  }
+
+  function displayTable() {
+    // delete current rows
+    let tbody = document.getElementsByTagName('tbody')[0]
+    while (tbody.rows.length > 0) {
+      tbody.deleteRow(0)
+    }
+
+    if (entries.length === 0) {
+      const p = document.getElementById('error-message')
+      p.innerHTML = 'No entries available'
+  
+      const paginationNav = document.querySelector('.pagination-nav')
+      paginationNav.classList.add('hide')
+    }
+
+    const start = currentPage * rowsPerPage
+    let end = (currentPage + 1) * rowsPerPage
+    end = end <= entries.length ? end : entries.length
+
+    for (var i = start; i < end; i++) {
+      insertRow(tbody, entries[i])
+    }
+  }
+
+  function insertRow(tbody, entry, index) {
+    const row = tbody.insertRow()
+
+    let html = '<tr>'
+    html += `<td><a class="no-wrap" href="${entry['reldir']}">${entry['build']}</a></td>`
+    html += '</tr>'
+    html += `<td class="no-wrap">`
+    if (entry['btype']) {
+        html += `${entry['btype']}`
+    }
+    html += `<td class="no-wrap">`
+    if (entry['branch']) {
+        html += `${entry['branch']}`
+    }
+    html += `</td>`
+    html += `<td>`
+    if (entry['testreport']) {
+        html += `<a href="${entry['testreport']}">Report</a>`
+    }
+    if (entry['regressionreport']) {
+        html += `<br><a href="${entry['regressionreport']}">Regressions</a>`
+    }
+    html += `</td>`
+
+    html += `<td>`
+    if (entry['perfreports']) {
+      entry['perfreports'].forEach((r) => {
+        html += `<a href="${r[0]}">${r[1]}</a> `
+      })
+    }
+    html += `</td>`
+
+    html += `<td>`
+    if (entry['ptestlogs']) {
+      entry['ptestlogs'].forEach((r) => {
+        html += `<a href="${r[0]}">${r[1]}</a> `
+      })
+    }
+    html += `</td>`
+
+    html += `<td>`
+    if (entry['buildhistory']){
+      entry['buildhistory'].forEach((bh) => {
+        html += `<a href="${bh[0]}">${bh[1]}</a> `
+      })
+    }
+    html += `</td>`
+
+    html += `<td>`
+    if(entry['hd']) {
+      entry['hd'].forEach((hd) => {
+        html += `<small><a href="${hd[0]}">${hd[1]}</a></small> `
+      })
+    }
+    html += `</td>`
+
+    html += `</tr>`
+    row.innerHTML = html
+  }
+
+  function updateActiveButtonStates() {
+    const pageButtons = document.querySelectorAll('.pagination-nav button')
+    pageButtons.forEach(button => {
+      if (button.textContent == currentPage+1) {
+        button.classList.remove('outline')
+      } else {
+        button.classList.add('outline')
+      }
+    })
+  }
+
+  function setCurrentPage(page) {
+    params.set('page', page)
+    setFilterParams()
+  }
+
+  function generatePageItems(totalPages, current, pageWidth) {
+    // See https://gist.github.com/kottenator/9d936eb3e4e3c3e02598
+    if (totalPages < pageWidth) {
+      return [...new Array(totalPages).keys()];
+    }
+    const left = Math.max(0, Math.min(totalPages - pageWidth, current - Math.floor(pageWidth / 2)));
+    const items = new Array(pageWidth);
+    for (let i = 0; i < pageWidth; i += 1) {
+      items[i] = i + left;
+    }
+    // replace non-ending items with placeholders
+    if (items[0] > 0) {
+      items[0] = 0;
+      items[1] = 'prev-more';
+    }
+    if (items[items.length - 1] < totalPages - 1) {
+      items[items.length - 1] = totalPages - 1;
+      items[items.length - 2] = 'next-more';
+    }
+    return items;
+  }
+
+  function createPageButtons() {
+    const totalPages = Math.ceil(entries.length / rowsPerPage)
+    const paginationNav = document.querySelector('.pagination-nav')
+
+    // Add page navigation buttons
+    const previousLi = document.createElement('li')
+    const previousBtn = document.createElement('a')
+    previousBtn.textContent = '<'
+    previousLi.appendChild(previousBtn)
+    paginationNav.appendChild(previousLi)
+    previousBtn.addEventListener('click', () => {
+      if (currentPage > 0) {
+        setCurrentPage(currentPage - 1)
+      }
+    })
+
+    const nextLi = document.createElement('li')
+    const nextBtn = document.createElement('a')
+    nextBtn.textContent = '>'
+    nextLi.appendChild(nextBtn)
+    nextBtn.addEventListener('click', () => {
+      if (currentPage < totalPages - 1) {
+        setCurrentPage(currentPage + 1)
+      }
+    })
+
+    const pageItems = generatePageItems(totalPages, currentPage, pageWidth)
+
+    // Add page buttons
+    pageItems.forEach(item => {
+      const pageLi = document.createElement('li')
+      if(typeof item === 'number') {
+        const pageButton = document.createElement('button')
+        pageButton.classList.add('outline')
+        pageButton.textContent = item + 1
+        pageButton.addEventListener('click', () => {
+          currentPage = item
+          setCurrentPage(currentPage)
+        })
+        pageLi.appendChild(pageButton)
+      } else {
+        const pageEllipsis = document.createElement('span')
+        pageEllipsis.textContent = '...'
+        pageLi.appendChild(pageEllipsis)
+      }
+      paginationNav.appendChild(pageLi)
+    })
+    paginationNav.appendChild(nextLi)
+  }
+
+  function showPage() {
+    createPageButtons()
+    updateActiveButtonStates()
+    displayTable()
+  }
+
+  async function mount() {
+    const url = window.location.href
+    params = new URLSearchParams(url.search)
+
+    await loadEntries()
+
+    // Call this function to create the page buttons initially
+    showPage(currentPage)
+
+    const hiddenItem = document.querySelector('.test-table')
+    hiddenItem.classList.remove('hide')
+
+    // Set the select value in the dropdown
+    let { type, branch, date } = getParams()
+
+    const buildType = document.getElementById('build-type-select')
+    const branchSelect = document.getElementById('branch-select')
+    const dateFilter = document.getElementById('date-filter')
+    if (type) {
+      buildType.value = type
+    }
+    if (branch) {
+      branchSelect.value = branch
+    }
+    if (date) {
+      dateFilter.value = date
+    }
+    buildType.classList.remove('hide')
+    branchSelect.classList.remove('hide')
+  }
+</script>
-- 
2.44.0


