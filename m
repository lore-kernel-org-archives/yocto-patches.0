Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095CEC5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 12:46:28 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6154.1787143584804554457
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Aug 2026 05:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=fJP+fIWf;
 spf=pass (domain: qbee.io, ip: 209.85.167.54, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso1235351e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Aug 2026 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1787143582; x=1787748382; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1cH3O1KRTpV80LtwHj5de5kKVXktUKTJeI3QQBpm6Y=;
        b=fJP+fIWfKlzj5QQj9CA1r4ewFaIQcnoQwzVeuVlAx3VYW/prAK92YM8fKDHMwNQbx5
         2Fy7gRTDNfr/vbBsisw01iqTRc/GHBefVDOwDh2urCVPSOAecMrjFkIp/odtKiVmUleu
         pLYqigNrGbLPW/VsoLiyaIwyQ7rEL2AjYQFsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143582; x=1787748382;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1cH3O1KRTpV80LtwHj5de5kKVXktUKTJeI3QQBpm6Y=;
        b=ARB3NXVZ9z1ChYzQxAR0Yc5ooJSPpP9SO0k9dkvdr704laS5tf3Omil9GOPMOmSu9A
         37ZvdEJy4/wuQezL0uIEDL+QbBKpmYkwyBaT4jw/SH0+zcPpNZPqf1Wm7v9aorDknZD/
         3bKF7CA9ERAzhc3zicakXKU9NPmTJtCzk6+mduJIL34AmGw2tWPXtzGwE1RiEfJeUUKD
         nLVf+iD388wZjARP43iQHG0mk+ED1YRs3FqtjoRvHGiFuO1YPk1JeortQ7pz6d7eNDxN
         su7smGFqmmBI9njQTk3inwlm2uza9Fl9E4jv6UhdqIlRCKO7ICYn56CNT5FFXgE/UVN5
         AyNw==
X-Gm-Message-State: AOJu0Yy3cguN0gXTXe4FcKzhJ1EIxIuLNgI0Q3P6nst9zz5A2pSKK+SW
	D1xxJH2qGEW4DLMxzyuoMgeQJ3aIJjWvSb6caH7Cwl0I1wN58Py2TXJCMp+SHtjpGju73yoKya2
	yP681KP4=
X-Gm-Gg: AR+sD11mT1TuLSTYGvnjLATxw8rXlb3qTZeVgz92ZaPQeAtoBNUQFs2N95I6dXU7ZDR
	jiFjnqwB0h63tO8P6DpAmqHsz/CWLkQJp9Y0yNZOmtjRZtxF85UPh3NWO7RJa7PcCpJZZaYnLoP
	K2vWVppAk5oQma69OJ69y5vcvYsl4ezZd2ape2DgPAjmfrWBWCUk2cgFvK5oyM/dShXPFPrDCJs
	hNleQP8EEZCLra8xcEkYAYVRx8iAW1EhjA99bgs6MJ8a6M9MGLp/8vRUXG6PxsShh50myAYNxPh
	NZS0ZTt5cdOoT0mWvFt2XzeqPajA1zGLOgICNmHVCCmxm5Cf72JlKbk43GodI8Suk5TtUb03CyO
	KzvNlY20x/s6qKRs5xWwH1k9wcNXw9Izex/fvwdABypbcdzbsNDgjwnjL3l93PFia8wsILSB5PW
	lLxCUqxTJuTksYnPv1D46CQ86h1CmxgCHrtpLgWW+EtRyou4PS1MzTCtf88AGLJhJHrI5nRWOh6
	/YDgT/NnwX5U/xLSw==
X-Received: by 2002:a05:6512:33c5:b0:5b2:a339:b422 with SMTP id 2adb3069b0e04-5b478bf4a04mr1538240e87.14.1787143582246;
        Wed, 19 Aug 2026 05:46:22 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5b47885c423sm500309e87.32.2026.08.19.05.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 05:46:21 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] Show layer dependencies recursively
Date: Wed, 19 Aug 2026 14:46:17 +0200
Message-ID: <20260819124617.94007-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Aug 2026 12:46:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4675

Implements: https://bugzilla.yoctoproject.org/show_bug.cgi?id=12599

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 layerindex/static/css/additional.css |   4 +
 templates/layerindex/detail.html     | 105 ++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)

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
index 11c7df7..793e6de 100644
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
@@ -444,6 +527,24 @@
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
+                    console.log("layerBranchId", layerBranchId);
+
+                    $(this).append(expandLayerDependencies(layerBranchId, []));
+                });
+            });
+
             clearRecipeSearch();
         });
     </script>

