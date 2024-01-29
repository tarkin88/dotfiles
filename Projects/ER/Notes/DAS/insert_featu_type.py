from django_multitenant.utils import set_current_tenant

from core.models import DASTenant
from mapping.models import *

tenant = DASTenant.objects.first()
set_current_tenant(tenant)
t = FeatureType.objects.create()
s = FeatureSet.objects.create()
s.types.add(t)
