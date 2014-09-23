require 'rails_helper'

RSpec.describe TemplateProjectImporter, :type => :service do
  let(:user) { create :user }

  it 'should import template project' do
    TemplateProjectImporter.execute user, File.read(Rails.root.join('spec/fixtures/template.json'))
    template_project = TemplateProject.first
    expect(template_project.user).to eq(user)
    expect(template_project.title).to eq('everyday')

    task1 = template_project.tasks[0]
    expect(task1.task_type).to eq('feature')
    expect(task1.status).to eq('unstarted')
    expect(task1.point).to eq(2)
    expect(task1.title).to eq('walking')
    expect(task1.description).to eq('walking park')

    task2 = template_project.tasks[1]
    expect(task2.task_type).to eq('feature')
    expect(task2.status).to eq('unstarted')
    expect(task2.point).to eq(1)
    expect(task2.title).to eq('launch')
    expect(task2.description).to eq('')
  end
end
