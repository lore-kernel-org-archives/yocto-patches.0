Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4414.1794732757238582898
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 00:52:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=I74KO8Bw;
 spf=pass (domain: qbee.io, ip: 209.85.221.43, mailfrom: piotr@qbee.io)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49134c8509fso2511735f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1794732755; x=1795337555; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBuUiLhlCxDb7CXTNKxspKY64IezvMezF6OMOnee3cc=;
        b=I74KO8BwI19Qj/GN0LKa64JZZ6Gfb6r4/8JOruCzD47mGn1GiV3E9EYUVvBsYYXK3V
         V+AzZmdfQi56Uf+1ALSCS8JbdHzpvQ81GAcMSpUi+vJ/MZqhLHMl+xxxNhXSG9/juBzt
         guQMzQFXrhkv6XAFVmdG+6eK1+Hhz7c4d2KMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794732755; x=1795337555;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cBuUiLhlCxDb7CXTNKxspKY64IezvMezF6OMOnee3cc=;
        b=GKspnxMvnv4WK1fQwyTiyvTmeagCSFXezwwwKDiJ4gvKpsbxTCodNtNg8Wp4TswVup
         J8NOPZSE1B7oW3WatSv8TcE3uvhXsR4n1wolnCMHqbz3rnPMj14b0vAaTkHJdOR6tGaL
         6/mhf72MmByqJTJoTgSFtOpcTr8P3BbUZUVKhCaxFyJzkNboLqlB0RMMF6y5R5LTbldL
         iqlkvC/iOea5btOH5XQIcCKp1XcikjRU/xpVNob40FHxvf1K1fJenFNbQ2hXkTryBD/8
         Y5GuKEsysYwnYxXzh5C7r/8tayP3b+USD/ksur6YXGIxjSR+EPHCqsvMtm20JtdFiI8A
         +BPg==
X-Gm-Message-State: APuU4Z96BYmysY4e6AAbabEtatS6AgNiweTnYdbtcEynMso7FEu9v3N3
	Dt89HKkFPK/oEDjFkeOZcy0lrJjwX+agNB8EXhyHKpZQwHMtoxmGW7k6sj4wcYfwAltRnxiS1Ze
	gaRbh5p8=
X-Gm-Gg: AYBFou3nvrwudC2AjXYjzyumbG+LjAMC6SgabeQUXBCh9b32dp2unqwyT9yblBDMkVV
	BIt9KuR0X75lN/E6w/So/702BTVHZQ6i7hef+8bPo1Gw7jLZQIx8xeycmhDBEwfQh4GFBxDgGnw
	yUkIfaJP6RETQrZuLkd07nTyyPB/diz4stClcMAaDDqWqW0EKOUMZDX0PkfiFCeFGPYWo+L1ECC
	EmzWFKxPmbEJxDcipC8clzIcC1MZQ3i3sDHZIX2jY2nRUGROFBpKt/gBw6XUrTbwA87z3I/N6at
	XB66dT0XaVLrl2bIZFF4inn9W1RCCaA5rjz91dRGiZMb+RrJ19mzLJOGV8WMGIfEsfRYVKiNPe1
	G90xqy5o3JJwvxOfO4trKctnfHKgMO3ktUnPNhGKj6RA/5+Dyk4jlyeqZG09Ckq78pTblsjYH9h
	zPLuwhWN/xzMN+7dC0yB+t4boCulbiMNOzkKiZZmdUFgEyzkvzgaFwONsWRe/FExHOY+Pz8x60t
	h+R9D3/2/pG/VkQq39FInMqcgLL1Cfxij6WZZoRiQ6WsICIyLX70Wft/wKxdBxr0zLbJGSQp5eZ
	UTPBaQ2LbY0uz3aoMkbt6d7AG3SZVDglFr8yW5so4ijm2ckHRwmzsDxq6lhrLq+ICU8ec5pbDXU
	=
X-Received: by 2002:a5d:5d07:0:b0:48f:e879:5890 with SMTP id ffacd0b85a97d-49c727d1ea8mr17193025f8f.32.1794732754193;
        Sun, 15 Nov 2026 00:52:34 -0800 (PST)
Return-Path: <piotr@qbee.io>
Received: from localhost ([2a0d:3341:aac1:2c00:1d28:2145:2686:3f9e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c7390fe82sm15973469f8f.17.2026.11.15.00.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 00:52:33 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [PATCH] layerindex: add an RSS feed of recently published layers
Date: Sun, 15 Nov 2026 09:52:29 +0100
Message-ID: <20261115085229.88023-1-piotr@qbee.io>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 08:52:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5392
Content-Type: text/plain; charset="utf-8"

The layer index had no RSS feed. Add one that lists the 50 most
recently published layers, newest first, so that people can follow new
layers as they are added to the index.

The feed is served at /layerindex/layers/published/rss/. Every page
announces it to feed readers, and the page footer has a "new layers
feed" link to it. Each entry in the feed gives the layer's name, its
summary, a link to its page and the date it was published.

To know that date, layers get a new "published" field, which is set
whenever a layer's status changes to Published. Layers that were
published before this change have no date and are not in the feed, so
the feed starts out empty and fills up as layers get published. The
field is only used by the feed and is not included in the REST API.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 layerindex/feeds.py                           |  52 +++
 .../migrations/0056_layeritem_published.py    |  21 ++
 layerindex/models.py                          |   9 +
 layerindex/restviews.py                       |   4 +-
 layerindex/urls.py                            |   2 +
 templates/base.html                           |   2 +
 tests/test_published_layers_feed.py           | 314 ++++++++++++++++++
 7 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 layerindex/feeds.py
 create mode 100644 layerindex/migrations/0056_layeritem_published.py
 create mode 100644 tests/test_published_layers_feed.py

diff --git a/layerindex/feeds.py b/layerindex/feeds.py
new file mode 100644
index 0000000..3313661
--- /dev/null
+++ b/layerindex/feeds.py
@@ -0,0 +1,52 @@
+# layerindex-web - RSS feed definitions
+#
+# Copyright (C) 2026 Qbee AS
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+from django.contrib.sites.models import Site
+from django.contrib.syndication.views import Feed
+from django.urls import reverse
+
+from layerindex.models import LayerItem
+
+class PublishedLayersFeed(Feed):
+    """The most recently published layers, newest first."""
+    max_items = 50
+
+    def title(self):
+        site = Site.objects.get_current()
+        if site and site.name and site.name != 'example.com':
+            site_name = site.name
+        else:
+            site_name = 'OpenEmbedded Layer Index'
+
+
+        # Same form as the page titles in base.html
+        return '%s - recently published layers' % site_name
+
+    def description(self):
+        return 'Recently published layers'
+
+    def link(self):
+        return reverse('layer_list', args=('master',))
+
+    def items(self):
+        # Layers published before the published field existed have no date
+        # and are deliberately left out (see migration 0056). Only the fields
+        # used below are loaded.
+        return LayerItem.objects.filter(
+            status='P', comparison=False, published__isnull=False,
+        ).order_by('-published', 'name').only(
+            'name', 'summary', 'published')[:self.max_items]
+
+    def item_title(self, item):
+        return item.name
+
+    def item_description(self, item):
+        return item.summary
+
+    def item_pubdate(self, item):
+        return item.published
diff --git a/layerindex/migrations/0056_layeritem_published.py b/layerindex/migrations/0056_layeritem_published.py
new file mode 100644
index 0000000..b654ad6
--- /dev/null
+++ b/layerindex/migrations/0056_layeritem_published.py
@@ -0,0 +1,21 @@
+# Generated by Django 5.2.19 on 2026-11-15 07:51
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0055_recipe_text_fields'),
+    ]
+
+    # Deliberately no backfill: we don't know when existing layers were
+    # published, so they keep published = NULL and stay out of the published
+    # layers feed. Only layers published from now on get a date.
+    operations = [
+        migrations.AddField(
+            model_name='layeritem',
+            name='published',
+            field=models.DateTimeField(blank=True, db_index=True, editable=False, help_text='When the layer was last published', null=True),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index 1d72c55..5d96c26 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -7,6 +7,7 @@
 # SPDX-License-Identifier: MIT
 
 from django.db import models
+from django.utils import timezone
 from datetime import datetime
 from django.contrib.auth.models import User
 from django.urls import reverse
@@ -143,6 +144,7 @@ class LayerItem(models.Model):
     index_preference = models.IntegerField('Preference', default=0, help_text='Number used to find preferred recipes in recipe search results (higher number is greater preference)')
     comparison = models.BooleanField('Comparison', default=False, help_text='Is this a comparison layer?')
     updated = models.DateTimeField(auto_now=True)
+    published = models.DateTimeField(null=True, blank=True, editable=False, db_index=True, help_text='When the layer was last published')
 
     class Meta:
         verbose_name = "Layer"
@@ -150,6 +152,13 @@ class LayerItem(models.Model):
             ("publish_layer", "Can publish layers"),
         )
 
+    def save(self, *args, **kwargs):
+        # Record the time when the layer becomes published.
+        if self.status == 'P' and not LayerItem.objects.filter(pk=self.pk, status='P').exists():
+            self.published = timezone.now()
+
+        super().save(*args, **kwargs)
+
     def change_status(self, newstatus, username):
         self.status = newstatus
 
diff --git a/layerindex/restviews.py b/layerindex/restviews.py
index 91779f5..1b6b926 100644
--- a/layerindex/restviews.py
+++ b/layerindex/restviews.py
@@ -53,7 +53,9 @@ class BranchViewSet(ParametricSearchableModelViewSet):
 class LayerItemSerializer(serializers.ModelSerializer):
     class Meta:
         model = LayerItem
-        fields = '__all__'
+        # published is internal bookkeeping for the RSS feed; keeping it out
+        # also stops import_layers.py copying it from a remote index
+        exclude = ('published',)
 
 class LayerItemViewSet(ParametricSearchableModelViewSet):
     queryset = LayerItem.objects.filter(status__in=['P', 'X'])
diff --git a/layerindex/urls.py b/layerindex/urls.py
index 92f419f..32e51d9 100644
--- a/layerindex/urls.py
+++ b/layerindex/urls.py
@@ -20,6 +20,7 @@ from layerindex.views import LayerListView, LayerReviewListView, LayerReviewDeta
 from layerindex.models import LayerItem, Recipe
 from rest_framework import routers
 from . import restviews
+from .feeds import PublishedLayersFeed
 
 router = routers.DefaultRouter()
 router.register(r'branches', restviews.BranchViewSet)
@@ -82,6 +83,7 @@ urlpatterns = [
             template_name='layerindex/recipedetail.html'),
         name='recipe'),
     re_path(r'^layer/(?P<name>[-\.\w]+)/publish/$', publish_view, name="publish"),
+    re_path(r'^layers/published/rss/$', PublishedLayersFeed(), name='published_layers_feed'),
     re_path(r'^layerupdate/(?P<pk>[-\w]+)/$',
         LayerUpdateDetailView.as_view(
             template_name='layerindex/layerupdate.html'),
diff --git a/templates/base.html b/templates/base.html
index acf0a9f..669a658 100644
--- a/templates/base.html
+++ b/templates/base.html
@@ -22,6 +22,7 @@
     <link rel="stylesheet" href="{% static "css/bootstrap-theme.css" %}" />
     <link rel="stylesheet" href="{% static "css/additional.css" %}" />
     <link rel="icon" type="image/vnd.microsoft.icon" href="{% static "img/favicon.ico" %}" />
+    <link rel="alternate" type="application/rss+xml" title="Recently published layers" href="{% url 'published_layers_feed' %}" />
     <title>{{ site_name }}{% block title_append %} - {% endblock %}</title>
     {% block head_extra %}
     {% endblock %}
@@ -128,6 +129,7 @@
         <hr />
         <div class="footer">
             <a href="{% url 'history_list' %}">change history</a>
+            &bull; <a href="{% url 'published_layers_feed' %}">new layers feed</a>
             &bull; <a href="{% url 'about' %}">about this site</a>
             &bull; <a href="https://www.openembedded.org/wiki/Layers_FAQ">FAQ</a>
             &bull; <a href="https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Layer%20Index">report a bug</a>
diff --git a/tests/test_published_layers_feed.py b/tests/test_published_layers_feed.py
new file mode 100644
index 0000000..7554677
--- /dev/null
+++ b/tests/test_published_layers_feed.py
@@ -0,0 +1,314 @@
+import datetime
+import xml.etree.ElementTree as ET
+from email.utils import parsedate_to_datetime
+from urllib.parse import urlsplit
+
+import pytest
+from django.contrib.auth.models import Permission
+from django.contrib.sites.models import Site
+from django.urls import reverse
+from django.utils import timezone
+
+from layerindex.models import LayerItem
+
+DAY1 = datetime.datetime(2026, 1, 1, 12, 0)
+DAY2 = datetime.datetime(2026, 1, 2, 12, 0)
+DAY3 = datetime.datetime(2026, 1, 3, 12, 0)
+
+pytestmark = pytest.mark.django_db
+
+
+# --- fixtures ----------------------------------------------------------------
+
+@pytest.fixture
+def clock(monkeypatch):
+    """Control the current time: ``clock.now = DAY2``."""
+    class Clock:
+        now = DAY1
+    c = Clock()
+    monkeypatch.setattr(timezone, 'now', lambda: c.now)
+    return c
+
+
+@pytest.fixture
+def new_layer():
+    """Submit a layer, which starts out unpublished ('New')."""
+    def make(name, summary='A test layer', comparison=False, status='N'):
+        return LayerItem.objects.create(
+            name=name,
+            status=status,
+            layer_type='S',
+            summary=summary,
+            description=summary,
+            vcs_url=f'git://example.com/{name}.git',
+            comparison=comparison,
+        )
+    return make
+
+
+@pytest.fixture
+def publish(client, django_user_model):
+    """Publish a layer through the publish view, as a reviewer."""
+    reviewer = django_user_model.objects.create_user('reviewer', 'reviewer@example.com', 'pw')
+    reviewer.user_permissions.add(Permission.objects.get(codename='publish_layer'))
+    client.force_login(reviewer)
+
+    def do(layer):
+        response = client.get(reverse('publish', args=(layer.name,)))
+        assert response.status_code == 302
+        layer.refresh_from_db()
+    return do
+
+
+@pytest.fixture
+def edit():
+    """Change a layer's details and save it, e.g. ``edit(layer, summary='x')``."""
+    def do(layer, **changes):
+        for field, value in changes.items():
+            setattr(layer, field, value)
+        layer.save()
+    return do
+
+
+@pytest.fixture
+def unpublish():
+    """Take a layer out of the published state, as an admin would by
+    changing the status in the admin site."""
+    def do(layer, status='N'):
+        layer.status = status
+        layer.save()
+    return do
+
+
+@pytest.fixture
+def site_name():
+    """Name the site, as tools/site_name.py does: ``site_name('My Index')``."""
+    def do(name):
+        site = Site.objects.get_current()
+        site.name = name
+        site.save()
+    yield do
+    # The current site is cached outside the test's transaction
+    Site.objects.clear_cache()
+
+
+@pytest.fixture
+def feed(client):
+    """Fetch the feed. ``feed()`` lists layer names in feed order;
+    ``feed.entry(name)`` gives one item's fields; ``feed.channel()`` gives
+    the feed's own title and description."""
+    class Feed:
+        def _channel(self):
+            response = client.get(reverse('published_layers_feed'))
+            assert response.status_code == 200
+            assert response['Content-Type'].startswith('application/rss+xml')
+            return ET.fromstring(response.content).find('./channel')
+
+        def _items(self):
+            return self._channel().findall('./item')
+
+        def channel(self):
+            channel = self._channel()
+            return {
+                'title': channel.findtext('title'),
+                'description': channel.findtext('description'),
+            }
+
+        def __call__(self):
+            return [item.findtext('title') for item in self._items()]
+
+        def entry(self, name):
+            for item in self._items():
+                if item.findtext('title') == name:
+                    return {
+                        'link': urlsplit(item.findtext('link')).path,
+                        'description': item.findtext('description'),
+                        'published': parsedate_to_datetime(item.findtext('pubDate')).replace(tzinfo=None),
+                    }
+            raise AssertionError(f'{name} is not in the feed')
+    return Feed()
+
+
+# --- what shows up -------------------------------------------------------------
+
+def test_feed_is_empty_when_nothing_is_published(feed):
+    assert feed() == []
+
+
+def test_published_layer_is_in_the_feed(new_layer, publish, feed, clock):
+    layer = new_layer('meta-foo', summary='Foo support')
+
+    publish(layer)
+
+    assert feed() == ['meta-foo']
+    assert feed.entry('meta-foo') == {
+        'link': '/layerindex/branch/master/layer/meta-foo/',
+        'description': 'Foo support',
+        'published': DAY1,
+    }
+
+
+def test_newest_published_layer_comes_first(new_layer, publish, feed, clock):
+    clock.now = DAY1
+    publish(new_layer('meta-older'))
+    clock.now = DAY2
+    publish(new_layer('meta-newer'))
+
+    assert feed() == ['meta-newer', 'meta-older']
+
+
+# --- every way of publishing counts ---------------------------------------------
+
+def test_layer_published_in_the_admin_is_in_the_feed(new_layer, edit, feed, clock):
+    # The admin form and the import tools set the status and save, without
+    # going through the publish view
+    layer = new_layer('meta-admin')
+
+    clock.now = DAY2
+    edit(layer, status='P')
+
+    assert feed() == ['meta-admin']
+    assert feed.entry('meta-admin')['published'] == DAY2
+
+
+def test_layer_created_already_published_is_in_the_feed(new_layer, feed, clock):
+    new_layer('meta-imported', status='P')
+
+    assert feed() == ['meta-imported']
+    assert feed.entry('meta-imported')['published'] == DAY1
+
+
+def test_layer_published_in_the_admin_keeps_its_date_when_edited(new_layer, edit, feed, clock):
+    layer = new_layer('meta-admin')
+    edit(layer, status='P')
+
+    clock.now = DAY2
+    edit(layer, summary='Edited summary')
+
+    assert feed.entry('meta-admin')['published'] == DAY1
+
+
+# --- what doesn't show up -------------------------------------------------------
+
+def test_new_layer_is_not_in_the_feed(new_layer, feed):
+    new_layer('meta-waiting-for-review')
+
+    assert feed() == []
+
+
+def test_editing_an_unpublished_layer_does_not_add_it(new_layer, edit, feed):
+    layer = new_layer('meta-draft')
+
+    edit(layer, summary='Better summary')
+
+    assert feed() == []
+
+
+def test_unpublished_layer_leaves_the_feed(new_layer, publish, unpublish, feed):
+    layer = new_layer('meta-withdrawn')
+    publish(layer)
+
+    unpublish(layer)
+
+    assert feed() == []
+
+
+def test_no_update_layer_is_not_in_the_feed(new_layer, publish, unpublish, feed):
+    layer = new_layer('meta-frozen')
+    publish(layer)
+
+    unpublish(layer, status='X')
+
+    assert feed() == []
+
+
+def test_comparison_layer_is_not_in_the_feed(new_layer, feed):
+    new_layer('meta-compare', comparison=True, status='P')
+
+    assert feed() == []
+
+
+# --- updates don't count as publishing -----------------------------------------
+
+def test_editing_a_published_layer_keeps_its_place_and_date(new_layer, publish, edit, feed, clock):
+    clock.now = DAY1
+    edited = new_layer('meta-edited')
+    publish(edited)
+    clock.now = DAY2
+    publish(new_layer('meta-untouched'))
+
+    clock.now = DAY3
+    edit(edited, summary='Edited summary')
+
+    assert feed() == ['meta-untouched', 'meta-edited']
+    assert feed.entry('meta-edited')['published'] == DAY1
+
+
+def test_publishing_again_does_not_bump_the_date(new_layer, publish, feed, clock):
+    clock.now = DAY1
+    layer = new_layer('meta-foo')
+    publish(layer)
+
+    clock.now = DAY2
+    publish(layer)
+
+    assert feed.entry('meta-foo')['published'] == DAY1
+
+
+def test_republished_layer_gets_the_new_date(new_layer, publish, unpublish, feed, clock):
+    clock.now = DAY1
+    layer = new_layer('meta-back')
+    publish(layer)
+    unpublish(layer)
+
+    clock.now = DAY2
+    publish(layer)
+
+    assert feed.entry('meta-back')['published'] == DAY2
+
+
+# --- the feed itself -------------------------------------------------------------
+
+def test_feed_is_named_after_the_site(site_name, feed):
+    site_name('My Layer Index')
+
+    assert feed.channel() == {
+        'title': 'My Layer Index - recently published layers',
+        'description': 'Recently published layers',
+    }
+
+
+def test_feed_uses_the_default_site_name(feed):
+    assert feed.channel() == {
+        'title': 'OpenEmbedded Layer Index - recently published layers',
+        'description': 'Recently published layers',
+    }
+
+
+def test_published_date_is_not_in_the_rest_api(new_layer, publish, client):
+    publish(new_layer('meta-foo'))
+
+    response = client.get('/layerindex/api/layerItems/', {'format': 'json'})
+
+    data = response.json()
+    items = data['results'] if isinstance(data, dict) else data
+    (item,) = [i for i in items if i['name'] == 'meta-foo']
+    assert 'published' not in item
+    assert 'updated' in item
+
+
+# --- discovery -----------------------------------------------------------------
+
+def test_pages_advertise_the_feed(client):
+    response = client.get(reverse('about'))
+
+    assert 'type="application/rss+xml"' in response.content.decode()
+    assert reverse('published_layers_feed') in response.content.decode()
+
+
+def test_pages_link_to_the_feed_in_the_footer(client):
+    # The about page has no footer
+    response = client.get(reverse('history_list'))
+
+    link = '<a href="%s">new layers feed</a>' % reverse('published_layers_feed')
+    assert link in response.content.decode()
