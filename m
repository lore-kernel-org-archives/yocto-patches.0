Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4982.1794625323937100793
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 19:02:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=rc7kTGSm;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso814217a91.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 19:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794625323; x=1795230123; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sr/gHu6SkbmQZQDix2B6hMxJm+wuEx+STOCe9XFlI9c=;
        b=rc7kTGSmI6haOy0vr2iM4ukNXgLyVw6KSH7uj1OxWtvsRLqjdde89uf1f/3E9s2OeN
         FKb2wo4SNPCXkmyznLSaOW2A01TGq0zV3bYJJdFm7kvnsi2Eq5o+G4SEdCkFSFB82P10
         H8gq4hS23fKgXWfoLlmUUSnmnqWnIzbLPEePGKFSW78pzm38cQ0v+LevM7aA/Fn+J7hv
         RDAFiqh4wTzP/P1xV/Q5VeTzIKFvrZf01brYF9aEiUCJ9ehRL83DdyR5Sk9jfMlfnlqd
         62MMp1+XgBEw4WxVtMhQVriRAEPzS2iwj9JzZM9b2RcYGd7kC/1ETHVFdjAgj3bPZGiv
         PR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625323; x=1795230123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sr/gHu6SkbmQZQDix2B6hMxJm+wuEx+STOCe9XFlI9c=;
        b=e1DMCscmgzIxjQpSfhHEGao31dSm4cC+PwkCu3SS5XQ3Fdm6HGNCn3OY37qxt9jBQZ
         dj1ewGVI0uqNFCq6N/agPbyaIcgp5ajwDCIhOpe3wBwEhWp9npkqFndJaCKYq+fwFo3M
         3sKkh6tJHRIpAolNhgEJs3P6j9gBZv5cJkFXTZ+Gles4e6xk8ssgHzq772S4xSm5r4vb
         ijWVSwWcrd7go8cOpwnUejYQZH2bra1nKhhE28x28nQJjXwo13DadXud3m7cHYOLoZ3o
         o841vZnvQR9E5xGpQSNmpartsbcEyWV15ko1hyT79rlKBW0jh1LPFOm4O+rpgVP8zPQ+
         +gSw==
X-Gm-Message-State: APuU4Z+x7VRbYDD7/h4mVWTUFPnQ8ERkYQgY+7tRLGipm8KCuSOvMLm8
	PSD/15hvLuE9Xj86MSDY1LdmePV/AxeRqjEVGVNNFK3xOoffpkgh61Fh5rQMQPvK
X-Gm-Gg: AYBFou03zn1EO06AMUFDNk//Sy4gmKpdhctFsSVsMGcz4Eimu8Y9dqRe1G3Mgj3J+HB
	wgeRl6s1BOI87F9o2HLd1/zcCxaTRAXyG4E1TryWVfW2RnXCIiAWHfG0pCzRfpdqulMUI6z8J0u
	HLwXlEFppd5vYVZVC1WYpLOzgPKYPzS1pu7+pZoTzd1UT3pl+UxnQrmgdjv46VjdQULaF65tBUr
	yp6MxP+BSTmJd7Y6MHnCHfeRrH63itdJloAujfeakbvGMMb6DiE2kb2YCBH0E3l42ZuUKD9yWHM
	ZrKTZLLjP3/laoZCglWqxVGxKx8rr1e424dSVpvp/Zz1saZ1nlKQDfd4+YXXhEF1mCDPSdyx3xx
	rvOW9zpF0DrOs5ju5NiApFOgeonNiPOE08fvDbOtVIydBPKCTV5F9lmjCF1UtlNFoPcCzPdjp8F
	5uS5zmWfBYPmZijsQB/TvWd1AmwicWUwgMrBNeBWwARqcIIIQB26G5AShyUXFeUpuGHC73EMsBP
	4XeiPh5OIg3axuwFLEAbdMacUk0UvdmRpq7EMKAUeIwArkJC57zcBpcUvJ2iZX62B4I/UpkYQa9
	7h6PJhObzhVpeE6xQLhG7e9nyOw9sbp+6hSSdGvbJjYkctLg/23YkKak3VulMQ==
X-Received: by 2002:a17:90a:dfc6:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3b1b0b65a3cmr3962037a91.36.1794625321786;
        Fri, 13 Nov 2026 19:02:01 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm11834158a91.15.2026.11.13.19.01.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 19:01:59 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex: show when a layer branch is no longer updated
Date: Fri, 13 Nov 2026 19:01:53 -0800
Message-ID: <20261114030153.68645-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 03:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5361
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
On a test instance loaded with a copy of the layers.openembedded.org
database, 171 layer branches on master get the label: 57 layers marked
"No update" (e.g. meta-ros2-foxy) and 114 layer branches with updates
turned off (e.g. meta-efikamx, which has no LAYERSERIES_COMPAT).
Applies to master and to master-next.

 layerindex/models.py             | 11 ++++++++
 layerindex/views.py              |  2 +-
 templates/layerindex/detail.html |  7 +++++
 templates/layerindex/layers.html |  1 +
 tests/test_updates_disabled.py   | 45 ++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 1 deletion(-)
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
index 6c20f47..910499f 100644
--- a/templates/layerindex/detail.html
+++ b/templates/layerindex/detail.html
@@ -125,6 +125,13 @@
                     <span class="text-muted"><small>Last commit: {{ layerbranch.vcs_last_commit|timesince }} ago ({{ layerbranch.get_checkout_branch }} branch)</small></span>
                     </p>
                     {% endif %}
+                    {% with reason=layerbranch.updates_disabled_reason %}
+                    {% if reason %}
+                    <p>
+                    <span class="label label-default">not updated</span> <small class="text-muted">{{ reason }}, so the information here may be out of date.</small>
+                    </p>
+                    {% endif %}
+                    {% endwith %}
 
                     {% if layerbranch.active_maintainers.count > 0 %}
                     <h3>{% if layerbranch.active_maintainers|length == 1 %}Maintainer{% else %}Maintainers{% endif %}</h3>
diff --git a/templates/layerindex/layers.html b/templates/layerindex/layers.html
index daae8cb..73792f4 100644
--- a/templates/layerindex/layers.html
+++ b/templates/layerindex/layers.html
@@ -75,6 +75,7 @@
                     {% for layerbranch in layerbranch_list %}
                     <tr class="layertype_{{ layerbranch.layer.layer_type }}">
                         <td><a href="{% url 'layer_item' url_branch layerbranch.layer.name %}">{{ layerbranch.layer.name }}</a>
+                            {% with reason=layerbranch.updates_disabled_reason %}{% if reason %}<span class="label label-default" title="{{ reason }}">not updated</span>{% endif %}{% endwith %}
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

