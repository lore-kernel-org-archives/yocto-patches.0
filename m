Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5305.1794626918243633559
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 19:28:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Fsdq2P/p;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso867203a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 19:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794626917; x=1795231717; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/akgZZNgczcsbXKgEoyzk/t7tsfE02tnv1WIP50DMEc=;
        b=Fsdq2P/pBs9lI0W0aFnLA3NEprc3Jin9Drpedeyvdwt+BB4OT0H8xcrbpTaF1ycJ9n
         jJ2RfqYr2wvHvD/VMGNcnCx0IHT+8ZvQh9/wg17tdkIO9F7eukcfSIpyrY11wS7OlZkt
         HwSxb5aLB/vO8ZfpQpqZQmplW1w7N9AGO+R3VcCiErur61xLa5g7MB9JCIfKQmImZdrg
         loet+uPACexyQsODwNWnP51/cDCLD80t2qo/EWNBtop3uZnNX/mflH4YCORlpTnXoi/Q
         mkl+nmVBQhVzxpUJs2OvJIpLZy6pmBCsqI3oUeCab2obJNgeQvyErIqSP1jYVhpoT3AU
         vm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794626917; x=1795231717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/akgZZNgczcsbXKgEoyzk/t7tsfE02tnv1WIP50DMEc=;
        b=EJN2+P7RQvF9gFnANxday1h16Zftr/zGiHUqepJTgdNRUjNK+mq0rtFHSkDWI8/b/k
         TIRg4fD4cRg/wdEHiuzHgpl5JoozAg7LYOhvqC87NJu/F6iBtKLOWxEcI48B7wa1tOEL
         jUtQgA6B4KebtPrMKzo/eRLuIwoB6ZKeQA65iHDNc6kxrcDMDBLR5c/XHYCQUhllUsEv
         UyYV+TaTRxUUJptV/D6iZ/4u7VynfoJIYqUXIaNljkOWzx640iD1gEp24WOzO+gkEESV
         +wlsyMYL6uiHo8crs3qBl8a7EF6NepG0OwBEOfnBHVRJ3X1OBXqKyqIZZqyy/nJPTH7X
         IrTw==
X-Gm-Message-State: APuU4Z8SOTUZB8e8b0JSHfsSOge4ICVix39Jo7oxCHSONU6scwwoDrPo
	H9pDtDRXHkrecBL8V0+gjPJeFMNYG0hcTTXwyfK8gmEhxiyuZO/wg8X2I5+jMUWQ
X-Gm-Gg: AYBFou3BFO1RHDrgAc2UX/+Y2DAx5i/UtrkGJUrkZn4ZbL6/s68a1sMtLhka3EzgcWm
	Iwy21AlwOec7C7h3fKxMaIvElaxJNjTnaYorrKabPiw/TAHhcut13lcR/m+oIfW7orbG6BfI84u
	clfPwW9j8wH27qiDdmA46QxQKGRLCnYRCHm/5ZO+jraRVEq2agBH2dQImlUc6eipgb9Wj2nAapU
	I1nAtoCQHG/soFfjmrHxcpcA2vT3SEHQ3cgqxLlL2OjvjF0mEAYdFyHAurxwfyYsfTdtS4QEuRL
	BXOv/wd6yg0Wv/UqA8G+kOiUFCHCU6905S9rwyHk8pNH+Ppnf4cZLStd3cAUP9rs/Nl99UaVh+T
	5EtZPd2ZXtCcO6uHdIlOCHIPEAwbnvIhL0zNLp9aET7mhnRcwpuwE9AQN+vzi5/zNhJXhFD3DhH
	It04ILwlho8wELhJ5hVRGCOsntP0uTiaSjfPdEbjQbBij0HxleCnH/6OJE3lc8U8mic4V3Mlyf4
	Wl4jBqRP1n89dQELjLQMpPM1mZoc4uQ9JDopZGxOHgwgfbAtaE0So+fMa4tGcsu7jIaSJ40KQrK
	Rx6BpHjwZB41y5/sWnAaSun+uhFJ6W4k+uyUhpXZkqb7rclZSfDJ7H0Pjl47SA==
X-Received: by 2002:a17:90a:e016:b0:3b1:b9ed:5dd0 with SMTP id 98e67ed59e1d1-3b1b9ed5e3fmr2237460a91.35.1794626917445;
        Fri, 13 Nov 2026 19:28:37 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3af2dsm6995078a91.9.2026.11.13.19.28.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 19:28:36 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH v2] layerindex: show when a layer branch is no longer updated
Date: Fri, 13 Nov 2026 19:28:32 -0800
Message-ID: <20261114032832.73642-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 03:28:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5362
Content-Type: text/plain; charset="utf-8"

Updates can be turned off for a layer, a branch or a layer branch, but
only the admin interface showed it, so the layer list and layer pages
gave no hint that the information may be out of date. Show a "not
updated" label with the reason next to the layer in the layer list and
on the layer page.

[YOCTO #14781]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
v2: use a lighter grey for the "not updated" label (light grey with dark
grey text instead of Bootstrap's label-default), which was too bold with
171 of them in the master layer list. The label keeps label-default, so
a browser with an older copy of additional.css still shows it.

 layerindex/models.py                 | 11 +++++++
 layerindex/static/css/additional.css |  8 +++++
 layerindex/views.py                  |  2 +-
 templates/layerindex/detail.html     |  7 +++++
 templates/layerindex/layers.html     |  1 +
 tests/test_updates_disabled.py       | 45 ++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tests/test_updates_disabled.py

diff --git a/layerindex/models.py b/layerindex/models.py
index 1d72c55..d071788 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -334,6 +334,17 @@ class LayerBranch(models.Model):
     def test_file_url(self):
         return self.file_url('conf/layer.conf')
 
+    def updates_disabled_reason(self):
+        """Why the update script no longer updates this layer branch, if it
+        doesn't"""
+        if self.layer.status == 'X':
+            return 'Updates are disabled for this layer'
+        if not self.branch.updates_enabled:
+            return 'Updates are disabled for the %s branch' % self.branch.name
+        if not self.updates_enabled:
+            return 'Updates are disabled for this layer on the %s branch' % self.branch.name
+        return ''
+
     def get_checkout_branch(self):
         """Get the branch that we actually need to check out in the repo"""
         if self.actual_branch:
diff --git a/layerindex/static/css/additional.css b/layerindex/static/css/additional.css
index a3c0a3a..dcab5cd 100644
--- a/layerindex/static/css/additional.css
+++ b/layerindex/static/css/additional.css
@@ -321,3 +321,11 @@ td.info {
     height: 400px;
     overflow-y: scroll;
 }
+
+/* "not updated" label: lighter than label-default, still readable. It also
+   has label-default, so a browser with an older copy of this file still
+   shows it. */
+.label-default.label-not-updated {
+    background-color: #e8e8e8;
+    color: #555;
+}
diff --git a/layerindex/views.py b/layerindex/views.py
index 592311f..85c82d6 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -443,7 +443,7 @@ class LayerListView(ListView):
 
     def get_queryset(self):
         _check_url_branch(self.kwargs)
-        return LayerBranch.objects.filter(branch__name=self.kwargs['branch']).filter(layer__status__in=['P', 'X']).order_by('layer__layer_type', '-layer__index_preference', 'layer__name')
+        return LayerBranch.objects.filter(branch__name=self.kwargs['branch']).filter(layer__status__in=['P', 'X']).select_related('branch').order_by('layer__layer_type', '-layer__index_preference', 'layer__name')
 
     def get_context_data(self, **kwargs):
         context = super(LayerListView, self).get_context_data(**kwargs)
diff --git a/templates/layerindex/detail.html b/templates/layerindex/detail.html
index 6c20f47..b14d030 100644
--- a/templates/layerindex/detail.html
+++ b/templates/layerindex/detail.html
@@ -125,6 +125,13 @@
                     <span class="text-muted"><small>Last commit: {{ layerbranch.vcs_last_commit|timesince }} ago ({{ layerbranch.get_checkout_branch }} branch)</small></span>
                     </p>
                     {% endif %}
+                    {% with reason=layerbranch.updates_disabled_reason %}
+                    {% if reason %}
+                    <p>
+                    <span class="label label-default label-not-updated">not updated</span> <small class="text-muted">{{ reason }}, so the information here may be out of date.</small>
+                    </p>
+                    {% endif %}
+                    {% endwith %}
 
                     {% if layerbranch.active_maintainers.count > 0 %}
                     <h3>{% if layerbranch.active_maintainers|length == 1 %}Maintainer{% else %}Maintainers{% endif %}</h3>
diff --git a/templates/layerindex/layers.html b/templates/layerindex/layers.html
index daae8cb..fb07d90 100644
--- a/templates/layerindex/layers.html
+++ b/templates/layerindex/layers.html
@@ -75,6 +75,7 @@
                     {% for layerbranch in layerbranch_list %}
                     <tr class="layertype_{{ layerbranch.layer.layer_type }}">
                         <td><a href="{% url 'layer_item' url_branch layerbranch.layer.name %}">{{ layerbranch.layer.name }}</a>
+                            {% with reason=layerbranch.updates_disabled_reason %}{% if reason %}<span class="label label-default label-not-updated" title="{{ reason }}">not updated</span>{% endif %}{% endwith %}
                             {% if layerbranch.yp_compatible_version %}
                             <a href="{{layerbranch.yp_compatible_version.link_url}}"><img src="{{layerbranch.yp_compatible_version.image_url}}" alt="{{layerbranch.yp_compatible_version.description}}" class="yp-icon" title="{{layerbranch.yp_compatible_version.description}}" ></a>
                             {% endif %}
diff --git a/tests/test_updates_disabled.py b/tests/test_updates_disabled.py
new file mode 100644
index 0000000..7fcdf50
--- /dev/null
+++ b/tests/test_updates_disabled.py
@@ -0,0 +1,45 @@
+# layerindex-web - test the indication that a layer branch is no longer updated
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.urls import reverse
+
+from layerindex.models import Branch, LayerBranch, LayerItem
+
+
+def make(name, status='P'):
+    master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    layer = LayerItem.objects.create(name=name, status=status, layer_type='A', summary=name,
+                                     description=name, vcs_url='git://example.com/%s.git' % name)
+    return LayerBranch.objects.create(layer=layer, branch=master)
+
+
+@pytest.mark.django_db
+def test_updates_disabled_reason():
+    # [YOCTO #14781] updates can be off for the layer, the branch or the layer branch
+    lb = make('meta-a')
+    assert lb.updates_disabled_reason() == ''
+    lb.updates_enabled = False
+    assert lb.updates_disabled_reason() == 'Updates are disabled for this layer on the master branch'
+    lb.branch.updates_enabled = False
+    assert lb.updates_disabled_reason() == 'Updates are disabled for the master branch'
+    lb.layer.status = 'X'
+    assert lb.updates_disabled_reason() == 'Updates are disabled for this layer'
+
+
+@pytest.mark.django_db
+def test_not_updated_label_on_layer_pages(client):
+    make('meta-updated')
+    make('meta-stale', status='X')
+    layers = client.get(reverse('layer_list', args=('master',))).content.decode()
+    assert layers.count('>not updated</span>') == 1
+    assert 'title="Updates are disabled for this layer"' in layers
+
+    page = client.get(reverse('layer_item', args=('master', 'meta-stale'))).content.decode()
+    assert 'not updated</span>' in page
+    assert 'Updates are disabled for this layer, so the information here may be out of date.' in page
+    page = client.get(reverse('layer_item', args=('master', 'meta-updated'))).content.decode()
+    assert 'not updated</span>' not in page

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

