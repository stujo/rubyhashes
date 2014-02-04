Hashes::Application.routes.draw do
  root to: 'notes#index', as: :notes_home

  match 'sandwich' => 'notes#sandwich', as: :notes_sandwich, via: [:get, :post]
  get 'codesample/:name' => 'notes#code_sample', as: :notes_code_sample

end
