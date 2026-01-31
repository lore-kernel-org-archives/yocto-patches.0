Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC1D79773
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 14:33:58 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9953.1769870028252218165
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 06:33:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=H0pdTI0X;
 spf=pass (domain: qbee.io, ip: 209.85.167.53, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dea72099eso3615839e87.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1769870026; x=1770474826; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9B+OTyvujt9XvW/VIxCKgCqDr1WrbkMdLdRMWyv61A=;
        b=H0pdTI0XkPRSJKUi5rzPbj5n4wxjImX8M+IoZEpV0ezYibjW8Zb7/SkKAQBj05kuKe
         BJuMAJR8iFkDa1xq4Z8eTn+GZRJEVRdZlHcN43Bs/Y50hzBkA3QBkXU5q7W0FBzckYtL
         YcrKh1EW34o+zCdCP3H6uokCoToxd4X/Ra5Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769870026; x=1770474826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9B+OTyvujt9XvW/VIxCKgCqDr1WrbkMdLdRMWyv61A=;
        b=LQP8LLUd4QCeKaiI1fjIE4kN+1okiM+FFkbiYWLnJ02joSyeubNbpFZP062VCqTMqp
         GpizAFC2LSmV7ZA7PGL2VAEROL0gIzvo7+646EHn4vE5g7n5TjkaDJ2sg3J9uozdwdCg
         j7v8yAknTaCTRy8/k24hzPVHQL4At5FOxHUIY78AK7QhI+R5fhLpoMQRSsdxoeh7vBal
         lge0t9+8490TzzhTrlNNTkcoLrwTJovZKQdsS9Vb+Gxy/qJgWBZdP9aEP0lhIpbxgNim
         RNUpG5vMRKXHm8wq/QeRR1JkZN7pGwOMv2/ungj488PZFmHxBXbKhJmR7ZbvtHiClFmm
         72OQ==
X-Gm-Message-State: AOJu0YwN4f0tIo30XKQ1q8n+m42GLYDGSJrZmgRHms17sUcu3H5DAJoV
	oNFQUxYrTYi5bK5DNL+IOO9sT6bIW/oopiNDGrYIBrbzUYrV0DgLmkA0mLvqs1cCZ75QBrf+V87
	5gQvCryE=
X-Gm-Gg: AZuq6aJT4nPf9DQJN8+7tVIXZ2vwutI9hlxvHP44pM6dhTc847ZIZ1l8YVi7g67oOvY
	lndB8gxg0/1dsQTD8aFr1DX7qw/NOT4iegOZQCQeNryhHW3wfxB9kQVISo4kU7iMueo4JB6wBgF
	G5ZrSRKLVqtArNRPa/5isrvpMWza2YP2id81T/JPwF63jh9ahPiQDSsBL09bbNk2GrCAwnMqr4o
	PrPOlfasdzwTLZJYqnAhM4T9jkLxzwiLUwDtrtR0w5tGloUhU97Y3knD0dymBmdgwp5u4lU3JEB
	SqKAuYUzRwr+iUqNcH0d1UFgXK2FYFlJuukHn2q3lCoSx9QZGNOKemLM+MpT2QvDIEfb91Kzhhn
	sZW30BxCCoygbAtNb94tax2sObwCPVs7/g+VF9llSGlvqcVT1T9tTMA8HJv1YAG64qFlsAHQBay
	VuB8Vdd8gBeuCtuBE9SlGG1vYN+jER23Y/u2t/aF+YldL9SBC2wVM=
X-Received: by 2002:a05:6512:1114:b0:59d:f2f3:7e9a with SMTP id 2adb3069b0e04-59e16443c97mr2240318e87.36.1769870025593;
        Sat, 31 Jan 2026 06:33:45 -0800 (PST)
Received: from localhost (telia-5908f8-154.connect.netcom.no. [89.8.248.154])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59e074b2d89sm2331914e87.49.2026.01.31.06.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 06:33:45 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] Re-implement pagination using built-in Django's Paginator.
Date: Sat, 31 Jan 2026 15:33:43 +0100
Message-ID: <20260131143343.23359-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 14:33:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3155

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 layerindex/templatetags/paginator.py       | 28 ++++++++++++++++++++++
 templates/layerindex/bulkchangesearch.html |  7 +-----
 templates/layerindex/classes.html          |  7 +-----
 templates/layerindex/classicrecipes.html   |  7 +-----
 templates/layerindex/distros.html          |  7 +-----
 templates/layerindex/history.html          |  7 +-----
 templates/layerindex/layers.html           |  7 +-----
 templates/layerindex/machines.html         |  7 +-----
 templates/layerindex/paginator.html        | 20 ++++++++++++++++
 templates/layerindex/recipes.html          |  7 +-----
 templates/layerindex/reviewlist.html       |  7 +-----
 templates/layerindex/updatelist.html       |  7 +-----
 12 files changed, 58 insertions(+), 60 deletions(-)
 create mode 100644 layerindex/templatetags/paginator.py
 create mode 100644 templates/layerindex/paginator.html

diff --git a/layerindex/templatetags/paginator.py b/layerindex/templatetags/paginator.py
new file mode 100644
index 0000000..60ada6e
--- /dev/null
+++ b/layerindex/templatetags/paginator.py
@@ -0,0 +1,28 @@
+from django import template
+from django.http import HttpRequest
+from django.core.paginator import Paginator
+
+register = template.Library()
+
+
+# Return new page URL for the current view.
+# Usage: {% page_url request 2 %}
+@register.simple_tag
+def page_url(request: "HttpRequest", page: int) -> "str":
+    new_query = request.GET.copy()
+    new_query['page'] = f'{page}'
+    return '?' + new_query.urlencode()
+
+
+# Return elided page range for the current page object.
+# Usage: {% page_obj|elided_page_range  %}
+@register.filter
+def elided_page_range(page_obj: "Paginator.page") -> "list[int]":
+    if not isinstance(page_obj.paginator, Paginator):
+        return []
+
+    return page_obj.paginator.get_elided_page_range(
+        number=page_obj.number,
+        on_each_side=3,
+        on_ends=1,
+    )
\ No newline at end of file
diff --git a/templates/layerindex/bulkchangesearch.html b/templates/layerindex/bulkchangesearch.html
index e8d6bd8..fad7975 100644
--- a/templates/layerindex/bulkchangesearch.html
+++ b/templates/layerindex/bulkchangesearch.html
@@ -90,12 +90,7 @@
                     <input type="submit" class="btn btn-default" name="add_all" value="Add all"></input>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     {% if searched %}
diff --git a/templates/layerindex/classes.html b/templates/layerindex/classes.html
index e99761b..0ba93ad 100644
--- a/templates/layerindex/classes.html
+++ b/templates/layerindex/classes.html
@@ -65,12 +65,7 @@
                 </table>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     {% if search_keyword %}
diff --git a/templates/layerindex/classicrecipes.html b/templates/layerindex/classicrecipes.html
index cf911a5..c4fe13c 100644
--- a/templates/layerindex/classicrecipes.html
+++ b/templates/layerindex/classicrecipes.html
@@ -287,12 +287,7 @@
                 </table>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     {% if searched %}
diff --git a/templates/layerindex/distros.html b/templates/layerindex/distros.html
index 0c1b276..4cacd84 100644
--- a/templates/layerindex/distros.html
+++ b/templates/layerindex/distros.html
@@ -65,12 +65,7 @@
                 </table>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     {% if search_keyword %}
diff --git a/templates/layerindex/history.html b/templates/layerindex/history.html
index 9ae4431..b4a1f62 100644
--- a/templates/layerindex/history.html
+++ b/templates/layerindex/history.html
@@ -60,12 +60,7 @@
 </table>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 
 
diff --git a/templates/layerindex/layers.html b/templates/layerindex/layers.html
index ae9befb..daae8cb 100644
--- a/templates/layerindex/layers.html
+++ b/templates/layerindex/layers.html
@@ -105,12 +105,7 @@
             </table>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     <p>No matching layers in database.</p>
diff --git a/templates/layerindex/machines.html b/templates/layerindex/machines.html
index 685506d..3b4971c 100644
--- a/templates/layerindex/machines.html
+++ b/templates/layerindex/machines.html
@@ -64,12 +64,7 @@
                 </table>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     {% if search_keyword %}
diff --git a/templates/layerindex/paginator.html b/templates/layerindex/paginator.html
new file mode 100644
index 0000000..99abff9
--- /dev/null
+++ b/templates/layerindex/paginator.html
@@ -0,0 +1,20 @@
+{% load paginator %}
+<nav aria-label="Pagination Navigation" class="text-center">
+    <ul class="pagination">
+        {% for i in page_obj|elided_page_range %}
+        {% if page_obj.number == i %}
+            <li class="page-item active">
+            <span aria-current="page">{{ i }}</span>
+            </li>
+        {% else %}
+            {% if i == page_obj.paginator.ELLIPSIS %}
+            <li class="pagination-ellipsis" aria-hidden="true"><span>{{ i }}</span></li>
+            {% else %}
+            <li class="page-item">
+                <a href="{% page_url request i %}" aria-label="Go to page {{ i }}">{{ i }}</a>
+            </li>
+            {% endif %}
+        {% endif %}
+        {% endfor %}
+    </ul>
+</nav>
\ No newline at end of file
diff --git a/templates/layerindex/recipes.html b/templates/layerindex/recipes.html
index 9c15e6c..cea7e2a 100644
--- a/templates/layerindex/recipes.html
+++ b/templates/layerindex/recipes.html
@@ -90,12 +90,7 @@
                 </table>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     {% if search_keyword %}
diff --git a/templates/layerindex/reviewlist.html b/templates/layerindex/reviewlist.html
index 18e0d78..c431621 100644
--- a/templates/layerindex/reviewlist.html
+++ b/templates/layerindex/reviewlist.html
@@ -69,12 +69,7 @@
     </div>
 
     {% if is_paginated %}
-    {% comment %}
-        {% load bootstrap_pagination %}
-        <div class="text-center">
-        {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-        </div>
-    {% endcomment %}
+    {% include "layerindex/paginator.html" %}
     {% endif %}
 {% else %}
     <p>No unpublished layers to review.</p>
diff --git a/templates/layerindex/updatelist.html b/templates/layerindex/updatelist.html
index b68a860..55091a9 100644
--- a/templates/layerindex/updatelist.html
+++ b/templates/layerindex/updatelist.html
@@ -54,12 +54,7 @@
 </div>
 
 {% if is_paginated %}
-{% comment %}
-    {% load bootstrap_pagination %}
-    <div class="text-center">
-    {% bootstrap_paginate page_obj range=10 show_prev_next="false" show_first_last="true" %}
-    </div>
-{% endcomment %}
+{% include "layerindex/paginator.html" %}
 {% endif %}
 
 {% endautoescape %}

