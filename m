Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A73C5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 12:50:57 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6180.1787143856226844010
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Aug 2026 05:50:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=X6D0efgl;
 spf=pass (domain: qbee.io, ip: 209.85.167.54, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b45f2e5f58so983630e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Aug 2026 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1787143854; x=1787748654; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyihPdTy5SfoSOG7kuFAOwjb1DqA9HYRMqM20bN0wqM=;
        b=X6D0efglC2PSF0jOLh3XgAv77QMdUyehLbwklgCm5KqQKfYnjjirOFZ6+PRP0S4Mgd
         SXVWBBn0T53Kn6vblmt3eZ93mBB7eFbUF/9hp8cZ7pr0wLS3yHS4Eg521EKsjjsbVUuv
         TpLaMN6YdYKcjJor8opVJ10D2Jeqa3LCl1tzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143854; x=1787748654;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyihPdTy5SfoSOG7kuFAOwjb1DqA9HYRMqM20bN0wqM=;
        b=kWcD0ptoBuYjs0k/aSYLsnVQghWSO4yng/vD5cdz9eOKSffnTBd3uTRPxjMiBfL8vN
         W6luvYwgMBCOQ0MXTGD9O2EeAxCsEaQ66JhsEjw0gL479QSGN5NDS3GYOSF9e85yzKZF
         Cn1HCL5pYPJoY7Sjr2p8+RnI8Ic+xITpe79c+f2WWJYzYbTIjMGuEg5LlkPrT0ggiLJU
         5su2WyhU4wF5feVVjTJED73gZpuULvxxbXPXW9M7FvA7t/rAh8OT8xcb8QPrlvboshOq
         +IlwLyA8btLvPV5O/SCaD/XpuAfAaCR4/XvSySuAx2AlAiq4fqeTAwHcYsR4NB/vdt43
         kQ3w==
X-Gm-Message-State: AOJu0YwhQqfjqpWWdBHJeqSiekNg+5k85ChiRqDn6Z+fuWSsCEUlloaC
	4VKI0WGOta45H8q9JLtXdhUjE4o2HBjDSBmV+JNhK+ezGQWVQPeRhT4h1ewpZPwNjaDLwVyLjA9
	8R0f8mzA=
X-Gm-Gg: AR+sD117drhvgwoNlFMiKNS2WZx4GmJo2Qmp1lYPrDt63IspL0z4cABgAy8aTLd2hYm
	c9BshA34hAczUCraopu0Hpj3LtSom3k7IPkSwf7zf/NZV//++SK3dpWAoF0w6xs9BjPN8O2/zXD
	BlC+PmVN4vDgfkwCwapQNLdk7i8U5WXEwLOLq2ASmkiphOvd0JyU2Sm5IxAPru1Z3PZaeYbWC/Z
	040Q4J1Ymuo6fBhOHAVB0gpkEcXxkUI9Xxka9EOwL2FQPIpvF6IhK0vPZuOrgYWrc5VSbPxmYQE
	7OpJ1wvEoaEcCjB1jO+4IGawinpXKvGEA+DfLM9+H35zncwrpV2FKfBzMAYNZBiirij3GasQAVq
	cYLt6By4CbZm1MM7/zLRQFVwNYFv14aEytG70dBUDfo642gVkmS+7h2zD2Ks7BUAX8qeUFbeFUc
	YZwwitiX0Dz6AJRehjt1Ml0HetKW+hSKvxb/Sw7PFkdl6Tk+SCMYXSL1CYtxCjMzR2x/XaB++43
	JFe/M9DhN7lbwtIfg==
X-Received: by 2002:a05:6512:1191:b0:5b0:15b1:3d5d with SMTP id 2adb3069b0e04-5b478be377fmr1542403e87.22.1787143854107;
        Wed, 19 Aug 2026 05:50:54 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5b478853b1dsm497993e87.2.2026.08.19.05.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 05:50:53 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] Show layer dependencies recursively
Date: Wed, 19 Aug 2026 14:50:51 +0200
Message-ID: <20260819125051.94223-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Aug 2026 12:50:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4676

Implements: https://bugzilla.yoctoproject.org/show_bug.cgi?id=12599

(without the debugging console.log)

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 layerindex/static/css/additional.css |   4 ++
 templates/layerindex/detail.html     | 104 ++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/layerindex/static/css/additional.css b/layerindex/static/css/additional.css
index ea4e555..a3c0a3a 100644
--- a/layerindex/static/css/additional.css
+++ b/layerindex/static/css/additional.css
@@ -52,6 +52,10 @@ textarea {
     font-size: 1.2em;
 }
 
+#dependencies_list ul {
+    font-size: 1em;
+}
+
 .description li {
     margin-bottom: 0.5em;
 }
diff --git a/templates/layerindex/detail.html b/templates/layerindex/detail.html
index 11c7df7..9ab6bf6 100644
--- a/templates/layerindex/detail.html
+++ b/templates/layerindex/detail.html
@@ -164,11 +164,18 @@
                             {% if layerbranch.get_required.count > 0 %}
                                 <h3>Dependencies </h3>
                                 <p>The {{ layeritem.name }} layer depends upon:</p>
-                                <ul>
+                                <ul id="dependencies_list">
                                     {% for dep in layerbranch.get_required %}
-                                        <li><a href="{% url 'layer_item' url_branch dep.dependency.name %}">{{ dep.dependency.name }}</a></li>
+                                        <li data-layerbranch="{{ dep.dependency.id }}">
+                                            <a href="{% url 'layer_item' url_branch dep.dependency.name %}">{{ dep.dependency.name }}</a>
+                                        </li>
                                     {% endfor %}
                                 </ul>
+                                <div class="text-right">
+                                    <button type="button" class="btn btn-default btn-xs" id="expand_dependencies">
+                                        Expand
+                                    </button>
+                                </div>
                             {% endif %} <!-- end of layerbranch.get_required.count -->
                             {% if layerbranch.get_recommends.count > 0 %}
                                 <h3>Recommends </h3>
@@ -415,6 +422,82 @@
             $(".recipestable > tbody > tr").show();
         }
 
+        // api abstracts access to the REST API endpoints and adds caching
+        // to avoid making multiple requests for the same data.
+        var api = {
+            // each calls the given callback for each item returned by the API
+            // endpoint with the given filter.
+            // If no data is returned, callback is never called.
+            each: function(endpoint, filter, callback) {
+                var cacheKey = endpoint + filter;
+                if (!(cacheKey in this)) {
+                    var url = "{% url 'api-root' %}" + endpoint + "/";
+                    this[cacheKey] = $.getJSON(url, {filter: filter});
+                }
+
+                this[cacheKey].done(function(data) {
+                    $.each(data, function(_, item) {
+                        callback(item);
+                    });
+                });
+            }
+        }
+
+        // layerUrl returns the URL for the layer detail page for the given layer name.
+        function layerUrl(layerName) {
+            return "{% url 'layer_item' url_branch '__layername__' %}".replace(
+                '__layername__', layerName
+            );
+        }
+
+        // expandLayerDependencies expands the dependencies of the layer
+        // referenced by parentListItem from the API and append them as a nested list,
+        // recursing to build the full tree.
+        // The 'seen' array tracks the current path to break dependency cycles.
+        function expandLayerDependencies(layerBranchId, seen) {
+            var branchId = "{{ layerbranch.branch_id }}";
+
+            if (!layerBranchId) {
+                return;
+            }
+
+            // keep track of seen layer branch IDs to avoid infinite recursion
+            // in case of circular dependencies
+            seen = seen.concat([layerBranchId]);
+
+            var nestedList = $('<ul></ul>');
+
+            var filter = "layerbranch:" + layerBranchId;
+            api.each("layerDependencies", filter, function(dependency) {
+                if (!dependency.required) {
+                    return;
+                }
+
+                var filter = "id:" + dependency.dependency;
+                api.each("layerItems", filter, function(layerItem) {
+                    var filter = "branch!layer:" + branchId + "!" + layerItem.id;
+                    api.each("layerBranches", filter, function(layerBranch) {
+                        var listItem = $('<li></li>').
+                            attr('data-layerbranch', layerBranch.id).
+                            append($('<a></a>').
+                                attr('href', layerUrl(layerItem.name)).
+                                text(layerItem.name));
+
+                        // detect circular dependencies to avoid infinite recursion
+                        if (seen.includes(layerBranch.id)) {
+                            listItem.append(' <span class="text-muted">(circular)</span>');
+                        } else {
+                            listItem.append(expandLayerDependencies(layerBranch.id, seen));
+                        }
+
+                        nestedList.append(listItem);
+                    });
+                });
+            });
+
+            return nestedList;
+        }
+
         $(document).ready(function() {
 
             $(function() {
@@ -444,6 +527,23 @@
                 $('.label-inverse').tooltip();
             });
 
+            // When the "Expand" button is clicked, hide the button and start
+            // expanding dependencies for each top-level dependency.
+            $("#expand_dependencies").click(function() {
+                $(this).hide();
+
+                $("#dependencies_list > li").each(function() {
+                    if ($(this).children('ul').length > 0) {
+                        // already expanded, skip
+                        return;
+                    }
+
+                    var layerBranchId = $(this).data('layerbranch');
+
+                    $(this).append(expandLayerDependencies(layerBranchId, []));
+                });
+            });
+
             clearRecipeSearch();
         });
     </script>

