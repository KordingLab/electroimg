function n_branches = number_of_branches(parent)

a = sort(parent);
a = a(find(a>0));
n_branches = size(find(diff(a)==0),1);
