Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5433.1794627676024238428
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 19:41:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=G2ujHe+q;
 spf=pass (domain: gmail.com, ip: 209.85.215.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc758830601so2151820a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 19:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794627675; x=1795232475; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=06zj0RTxGCrh4+r20nMomE6XdGe02JHUYMgoXbOF5js=;
        b=G2ujHe+q8pb7bJK4MNpnlHhsJVBMNMmqhcbhKFbN3oVmOnkElNsGrewO5oQpC+fkN7
         LPipPW9v+zIPWVatfXQwAOV1GCNF/hENQwRQVHfxOxfD0cbSACB6uHjYUuPw30+tVdQJ
         8Z6fpO8E0kUD4mEJIgINMneosGWz7bvxF/hTk1PXqNKCMl0ovL4MDlcsoXSfjNZNPvSM
         QGM8PKU4Kh0fKZZg8KVDkGJGc/gNVJiUCoNzmJKDvt2am0gaV8uB5m3bnSsmEND3dtkX
         oG9zvgl0S9bfnWdWu55UquFnyQeX4iRDaZKS8sk7HMy3D3t7PstExbknkKGuV7HnX6Oo
         4wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794627675; x=1795232475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06zj0RTxGCrh4+r20nMomE6XdGe02JHUYMgoXbOF5js=;
        b=qqE130nCKCME13k9Rv3zrY43sOXUwC0Dg8KBLpn77jL5P8FLH58YggMluCDrSUqbxy
         lx3tRWkdL7ZM5dul9Xa1Wj/l0m4Qk4aqHrgQXABpPZVnlt57MKK6y7pm+jYPX9zlcciP
         svIrvUvpfy6zM54qkvTkYgQx8l34MEl+zvuTCdaMYR1tC7BDRYkuZokhvvDKk4vqDflg
         aI/JgFOIdLzzfJyfhfbJ67L4drytidztCsVglGjUaAvH0uc7lzYCRgIIuAMcWmdUT3ui
         KEEhxWLQUUMS46yloo4FPpGHgnQpp81LlR9BlghzNRJREAlQBnIMOyvdrS4WkiO1746K
         vkQA==
X-Gm-Message-State: APuU4Z/3UH0cZJZHWiDzPYze6RQx3lmwrsWeRjS2bf14YyszYgLV3TyJ
	5z1fgClJskTGNn708f2R80vSvtEoxBsiihGDNHCpZ+vGv5nG0uMrMLoKk026Kl33
X-Gm-Gg: AYBFou1irf9/lbNdkUIaZIOs4mObZvvfxpyw8tz5KmnE/+BroXED31oXpxGNqDqvZX6
	oTSuZVg3D4WlsMkpPjjqkeq0C9w6R8QU+P/bihaOwlB/Wk0RONlkd4owONUjmm1yxoShwaB2yiw
	y7j5UxeqMRzCBpLrxhBnnsWZKbK2QmqL96mgAVnwnj/X5CHPUmDEFU6JTlNUBC7csnDAFRbmgn2
	Rgbgtil+b7CTnS/vwYdWHtck3M8UXyj8z+ZassU9hnX0nPsHZ663SgxBymjl9gH+AEs4q14gKUO
	8DVhX8Xvyu2hHKobM9AwXe0el47Liq/likrBOF3PQcmsNs2EIM+HyzXDEz8C2SfZl8D9JY+nURt
	Yz2cKbRwqxIGsB6c6Shf0sdR60W6fw1oTtllLKHUFRhqfrC3y8LTti3ABHhjciHAKZZeOwifzhn
	QEUrnR7t65nU4bynGcrtGi/5uqxwOjJHI5c4Itkq0XlzafCeuuQMZ/WvLYkwMIzwAcuLfSx8pVW
	OBcFSXKaHlmQ5r6FU2+lnIY+1wX64msYpcZ+ZMfPO+loaMEBsXgDJ9Q+CMFozO9rLfKPoaP1tls
	gFkArZ1gUPp5MOK7wpb3OJ2m/9B0q6WofHZbqsOOaAAdaZRU9ELJNvKwDXJwBDBliD02Iwa0UNY
	Ex3/sPmk=
X-Received: by 2002:a17:90b:4a05:b0:3ac:9176:e81c with SMTP id 98e67ed59e1d1-3b1b0cdb2efmr3897123a91.46.1794627675212;
        Fri, 13 Nov 2026 19:41:15 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3a903sm7608067a91.8.2026.11.13.19.41.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 19:41:14 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex: show a layer's branches in a table on the layer page
Date: Fri, 13 Nov 2026 19:41:11 -0800
Message-ID: <20261114034111.76580-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 03:41:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5363
Content-Type: text/plain; charset="utf-8"

For a layer like meta-qt6, where each branch tracks a different git
branch, the layer page only showed the branch being viewed. Add a
Branches tab listing every branch of the layer, with the git branch it
tracks (actual_branch), the date of its last commit, and whether it is
still updated.

[YOCTO #15380]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
This depends on "[PATCH v2] layerindex: show when a layer branch is no
longer updated" (bug 14781) for the updates column, and applies on top
of it and on master-next. Editing the branches, also asked for in the
bug, would follow separately.

On a test instance loaded with a copy of the layers.openembedded.org
database, meta-qt6's table shows each branch's git branch (master: dev,
scarthgap: lts-6.8, kirkstone: 6.5, ...) and that langdale is no longer
updated.

 layerindex/views.py              |  1 +
 templates/layerindex/detail.html | 23 ++++++++++++++++
 tests/test_branch_table.py       | 45 ++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 tests/test_branch_table.py

diff --git a/layerindex/views.py b/layerindex/views.py
index 85c82d6..a041226 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -493,6 +493,7 @@ class LayerDetailView(DetailView):
             context['appends'] = layerbranch.bbappend_set.order_by('filename')
             context['classes'] = layerbranch.bbclass_set.order_by('name')
             context['updates'] = LayerUpdate.objects.filter(layer=layerbranch.layer, branch=layerbranch.branch).order_by('-started')
+        context['layerbranches'] = LayerBranch.objects.filter(layer=layer, branch__hidden=False, branch__comparison=False).select_related('layer', 'branch').order_by('branch__sort_priority')
         context['url_branch'] = self.kwargs['branch']
         context['this_url_name'] = resolve(self.request.path_info).url_name
         if 'rrs' in settings.INSTALLED_APPS:
diff --git a/templates/layerindex/detail.html b/templates/layerindex/detail.html
index b14d030..7e79b3f 100644
--- a/templates/layerindex/detail.html
+++ b/templates/layerindex/detail.html
@@ -224,6 +224,7 @@
             {% if updates.count > 0 %}
                 <li><a href="#updates" data-toggle="tab">Updates</a></li>
             {% endif %}
+            <li><a href="#branches" data-toggle="tab">Branches</a></li>
         </ul>
 
         <div class="tab-content">
@@ -393,6 +394,28 @@
                     </table>
                 </div>
             {% endif %}
+            <div class="tab-pane" id="branches">
+                <table class="table table-bordered">
+                    <thead>
+                        <tr>
+                            <th>Branch</th>
+                            <th>Git branch</th>
+                            <th>Last commit</th>
+                            <th>Updates</th>
+                        </tr>
+                    </thead>
+                    <tbody>
+                        {% for lb in layerbranches %}
+                            <tr>
+                                <td>{% if lb.branch.name == url_branch %}<b>{{ lb.branch.name }}</b>{% else %}<a href="{% url 'layer_item' lb.branch.name layeritem.name %}">{{ lb.branch.name }}</a>{% endif %}</td>
+                                <td>{{ lb.get_checkout_branch }}</td>
+                                <td>{% if lb.vcs_last_commit %}{{ lb.vcs_last_commit|date:"Y-m-d" }}{% else %}<span class="text-muted">not indexed</span>{% endif %}</td>
+                                <td>{% with reason=lb.updates_disabled_reason %}{% if reason %}<span class="label label-default label-not-updated">not updated</span> <small class="text-muted">{{ reason }}</small>{% else %}updated{% endif %}{% endwith %}</td>
+                            </tr>
+                        {% endfor %}
+                    </tbody>
+                </table>
+            </div>
         </div>
  
 
diff --git a/tests/test_branch_table.py b/tests/test_branch_table.py
new file mode 100644
index 0000000..9d3b0c9
--- /dev/null
+++ b/tests/test_branch_table.py
@@ -0,0 +1,45 @@
+# layerindex-web - test the table of a layer's branches on the layer page
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import re
+from datetime import datetime
+
+import pytest
+from django.urls import reverse
+
+from layerindex.models import Branch, LayerBranch, LayerItem
+
+
+@pytest.mark.django_db
+def test_branch_table(client):
+    # [YOCTO #15380] like meta-qt6, where each branch tracks a different git branch
+    master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    master.sort_priority = 1
+    master.save()
+    scarthgap = Branch.objects.create(name='scarthgap', bitbake_branch='2.8', sort_priority=2)
+    kirkstone = Branch.objects.create(name='kirkstone', bitbake_branch='2.0', sort_priority=3,
+                                      updates_enabled=False)
+    hidden = Branch.objects.create(name='hiddenbranch', bitbake_branch='master', hidden=True)
+    layer = LayerItem.objects.create(name='meta-qt', status='P', layer_type='S', summary='qt',
+                                     description='qt', vcs_url='git://example.com/meta-qt.git')
+    LayerBranch.objects.create(layer=layer, branch=master, actual_branch='dev',
+                               vcs_last_commit=datetime(2026, 11, 1))
+    LayerBranch.objects.create(layer=layer, branch=scarthgap, actual_branch='6.8')
+    LayerBranch.objects.create(layer=layer, branch=kirkstone, actual_branch='6.2')
+    LayerBranch.objects.create(layer=layer, branch=hidden)
+
+    page = client.get(reverse('layer_item', args=('master', 'meta-qt'))).content.decode()
+    table = page[page.index('id="branches"'):]
+    rows = [re.sub(r'<[^>]+>|\s+', ' ', r).split() for r in re.findall(r'<tr>(.*?)</tr>', table, re.S)[1:]]
+
+    assert [r[:2] for r in rows] == [['master', 'dev'], ['scarthgap', '6.8'], ['kirkstone', '6.2']]
+    assert rows[0][2:] == ['2026-11-01', 'updated']
+    assert rows[1][2:5] == ['not', 'indexed', 'updated']
+    assert 'Updates are disabled for the kirkstone branch' in table
+    assert 'hiddenbranch' not in table
+    # The current branch is not a link; the others are
+    assert reverse('layer_item', args=('scarthgap', 'meta-qt')) in table
+    assert reverse('layer_item', args=('master', 'meta-qt')) not in table

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
prerequisite-patch-id: d08807a0e95947278caa6b5f1c6c2e6e74dba0e5
-- 
2.56.0

