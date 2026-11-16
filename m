Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6139.1794870259132390383
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:04:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=ExAIK0cJ;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so1930521b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794870258; x=1795475058; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+8INfbtuqsY7AFsPFW966X/DkA3X6Onl2ULlEF6Jdo0=;
        b=ExAIK0cJ2qA0kgj1bXxeBRlgC4z1jptXXGX0ECmwp7VXLgxGNnv/eJXKRR0a1ffuiv
         wdNrxryCkYgpQd3eeawoDzswzXPBKSIMB+yTvpOiCbW9FF+LNGvCanhDSw8JGqnx0kRX
         NxrIHMfss32QYqSZr+byP1bQLwzmDb+O1t4mJ1mhy8qW3mMfzkX2BQP8Ji75hWXu5VE3
         4EF2enhCXly7+yft6sQFeYg6clZu2YYO6+Ft8D5pKD5hgHhRerAmiPew6251KChDhBIp
         6Wpb+y8mCA9N4BBDywYPfS9hqbq9nMRiIpJedijFld24qlTaWmYGNkpS2ufkLCCGvgyn
         4/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870258; x=1795475058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+8INfbtuqsY7AFsPFW966X/DkA3X6Onl2ULlEF6Jdo0=;
        b=gEpvj/HleOEen2FQQrwUxZ8jaPNtBWQhFIdHo/Om/3QeFwCC0T+nhnpCF/P6okQFsK
         McHvBcTvgKeT6Ld6rcZwFxiIlNRfbU5GIEUMGoE30jOq2gcHjFOsxdehqWBMAPTcvEFH
         9nwoJmg0kLcTeyhTdjMev9c/lQl5XFXOFjx1il+i9C167EZG40Ma/YNBLkaMLBmomikF
         bwQbh+81FJMonvnQVmqhk0aHpttLDQkB0Wm4BmJ7p+pTcA9oxvBjTbJjEM+XX68o4CRz
         ohzyEZxiAadYK3YAGQOimK+2NFFPqRjtpg9OYVB6yr5l3sd5ij/3qC5Pi/5Fj1iapZ3b
         WuyA==
X-Gm-Message-State: APuU4Z8R/aG15QLdu0PsCKSRPGMt4McESU5IBKHjHh5kEs516gzyXq5K
	IP/jP/7KoIWL9zE1z8ooCQIflJRkjx5uKEZNn/ATn4U+o72a/pVZpgr490CV4g==
X-Gm-Gg: AYBFou3JqqA/GU0ssN9K1Vn34JaaYiwxwSJWsYM+IHiRwZGnwD5gqj+dYYue7GTFAMX
	YobVjUozUfHtOQjRJAZIm5UVQCfogYl9wLhcc5BcYmRZUP1Io6dqTYiTNu/k67pKByYNxk6912f
	7T6w0UPL9T7DTLzluVtb1k7ZnCmsjFXr7yq0Tf+zfh1byMpGBXVQqmyiK+GM5hF2euvoSPm9724
	RRCn5rjhkfGek24N5H4GjJ7NzRx7XBlJt7gA8nxfZOye6rIazVtydwM8hRSAG2WajSOKGmGQJBE
	FWN10GeHOvSiHwq3PbMFD4ZT0sd+jydmCXwYlhcCK6Eb5Q4htwDh7q05v914BW6J8Y/j1H8VyYS
	Gd+MtIOUphLteHHQFOiomPFT/QLrYKIOVq2deFsioZVxyelSehcFnPg8OIKRH1OJKxsCMLv9WeV
	PgdsHA556xYOr6E2N5Gte5PNNW42mb7r/DK85esUX9t5SwtbS6lGmxef4pciveY97r5no6T3/O9
	u3DhQYIEzrMewrbecRHx7M8HVHX9qiXruqfw+CEn8prHUtfdpIRUOYQ+0IqlxWpPRPfbVOKdS6A
	rqD2JNHvh3MpLQ0i7ZddDL4aAi0+weO9KqLuIvbOw6dvXxWWJ9Q2WALPvUnXjA==
X-Received: by 2002:a05:6a00:3011:b0:8a0:70d8:a2ee with SMTP id d2e1a72fcca58-8beb84e3ff7mr11759217b3a.60.1794870258438;
        Mon, 16 Nov 2026 15:04:18 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a90f1sm4210535b3a.19.2026.11.16.15.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 15:04:16 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/4] layerindex/querysethelper.py: apply the API "orderby" parameter
Date: Mon, 16 Nov 2026 15:03:50 -0800
Message-ID: <20261116230401.42917-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116230401.42917-1-tim.orling@konsulko.com>
References: <20261116230401.42917-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:04:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5436
Content-Type: text/plain; charset="utf-8"

params_to_queryset() worked out the column and direction from
"orderby" but never ordered the queryset by them, so the parameter had
no effect. Order by it, with a 400 for a field path that doesn't exist.
It no longer evaluates the whole queryset just to check whether it is
empty first.

[YOCTO #16518]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/querysethelper.py | 27 +++++++++++++++++++++++----
 tests/test_restapi.py        | 30 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/layerindex/querysethelper.py b/layerindex/querysethelper.py
index 2ca466a..26f687a 100644
--- a/layerindex/querysethelper.py
+++ b/layerindex/querysethelper.py
@@ -8,7 +8,7 @@
 
 import operator
 import functools
-from django.core.exceptions import FieldError, ValidationError
+from django.core.exceptions import FieldDoesNotExist, FieldError, ValidationError
 from django.db.models import Q, CharField
 from rest_framework.exceptions import ParseError
 
@@ -124,6 +124,18 @@ def get_search_tuple(request, model):
     return (filter_string, search_term, ordering_string)
 
 
+def _check_field_path(model, path):
+    """Raise ParseError unless path (e.g. "layerbranch__layer__name") names a field"""
+    for name in path.split('__'):
+        if model is None:
+            raise ParseError("Invalid orderby: " + path)
+        try:
+            field = model._meta.get_field(name)
+        except FieldDoesNotExist:
+            raise ParseError("Invalid orderby: " + path)
+        model = field.related_model
+
+
 # returns a lazy-evaluated queryset for a filter/search/order combination
 def params_to_queryset(model, queryset, filter_string, search_term, ordering_string):
     if filter_string:
@@ -139,12 +151,19 @@ def params_to_queryset(model, queryset, filter_string, search_term, ordering_str
     if search_term:
         queryset = _get_search_results(search_term, queryset, model)
 
-    if ordering_string and queryset:
+    # insure only distinct records (e.g. from multiple search hits) are returned
+    queryset = queryset.distinct()
+
+    if ordering_string:
         column, order = ordering_string.split(':')
         if order.lower() == DESCENDING:
             column = '-' + column
+        # The ordering was worked out but never applied. A bad field path
+        # only fails when the query runs, so check it here (AI-generated,
+        # Claude Opus 5.5)
+        _check_field_path(model, column.lstrip('-'))
+        queryset = queryset.order_by(column)
 
-    # insure only distinct records (e.g. from multiple search hits) are returned
-    return queryset.distinct()
+    return queryset
 
 
diff --git a/tests/test_restapi.py b/tests/test_restapi.py
index a1f733e..fde1aec 100644
--- a/tests/test_restapi.py
+++ b/tests/test_restapi.py
@@ -60,3 +60,33 @@ class TestRestApiInvalidParameters(TestCase):
                                    {'filter': 'name:meta-test', 'format': 'json'})
         self.assertEqual(response.status_code, 200)
         self.assertEqual([i['name'] for i in response.json()], ['meta-test'])
+
+
+@pytest.mark.django_db
+class TestRestApiOrderby(TestCase):
+    """orderby sorts the results ([YOCTO #16518])"""
+
+    def setUp(self):
+        for name in ('meta-b', 'meta-a', 'meta-c'):
+            LayerItem.objects.create(name=name, status='P', layer_type='A',
+                                     summary='test', description='test',
+                                     vcs_url='git://example.com/%s.git' % name)
+
+    def names(self, orderby):
+        response = self.client.get('/layerindex/api/layerItems/',
+                                   {'orderby': orderby, 'format': 'json'})
+        self.assertEqual(response.status_code, 200)
+        return [i['name'] for i in response.json()]
+
+    def test_ascending(self):
+        self.assertEqual(self.names('name:+'), ['meta-a', 'meta-b', 'meta-c'])
+
+    def test_descending(self):
+        # DESCENDING in querysethelper.py
+        self.assertEqual(self.names('name:-'), ['meta-c', 'meta-b', 'meta-a'])
+
+    def test_unknown_related_field(self):
+        # "layerbranch" passes the field-name check; the rest of the path is wrong
+        response = self.client.get('/layerindex/api/layerItems/',
+                                   {'orderby': 'layerbranch__nosuchfield:+', 'format': 'json'})
+        self.assertEqual(response.status_code, 400)
-- 
2.56.1

